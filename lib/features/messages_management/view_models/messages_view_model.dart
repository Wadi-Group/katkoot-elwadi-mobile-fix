import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/core/utils/validator.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_api_result.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/mixins/pagination_mixin.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/navigation_drawer_mixin.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';
import 'package:katkoot_elwady/features/messages_management/models/messages_data.dart';
import 'package:katkoot_elwady/features/messages_management/models/read_message_data.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';

enum messagesCategory { wadi, international, local }

class MessagesViewModel extends StateNotifier<BaseState<List<Message>?>>
    with BaseViewModel, NavigationDrawerMixin, PaginationUtils {
  Repository _repository;

  MessagesViewModel(this._repository) : super(BaseState(data: []));

  // get messages from api
  Future getMessages(BuildContext context,
      {bool refresh = false, bool showLoading = true}) async {
    if (checkPerformRequest(refresh: refresh)) return;

    isPerformingRequest = true;
    if (refresh) {
      reset();
    }

    state = BaseState(data: state.data, isLoading: showLoading);

    bool userIsLoggedIn = ProviderScope.containerOf(context, listen: false)
        .read(di.userViewModelProvider.notifier)
        .isUserLoggedIn();

    BaseApiResult<MessagesData?> result;
    if (userIsLoggedIn) {
      //result = result_;

      result = await _repository.getMessages(
          hasToken: true, page: page, limit: limit);
    } else {
      var deviceState = await _repository.getOnesignalDeviceState();
      var installedAt = await _repository.installedAtTime();
      result = await _repository.getMessages(
          hasToken: false,
          page: page,
          limit: limit,
          deviceId: deviceState?.userId,
          installedAt: installedAt);
    }
    print(result.data);
    List<Message>? messages;
    int notificationNotSeenCount;
    if (result.data != null) {
      messages = result.data?.messages ?? [];
      notificationNotSeenCount = result.data?.notificationNotSeenCount ?? 0;
      ProviderScope.containerOf(context, listen: false)
          .read(di.unseenNotificationCountProvider.notifier)
          .setLocalUnseenNotificationCount(notificationNotSeenCount);

      var user = ProviderScope.containerOf(context, listen: false)
          .read(di.userViewModelProvider);
      if (user?.user != null) {
        user?.notificationNotSeenCount = notificationNotSeenCount;
        ProviderScope.containerOf(context, listen: false)
            .read(di.userViewModelProvider.notifier)
            .setLocalUserData(user);
      }
      page++;
      checkHasNext(result.data?.messages ?? []);

      messages =
          refresh ? result.data?.messages : [...state.data ?? [], ...messages];
      state = BaseState(data: messages, hasNoData: messages?.isEmpty ?? true);
    } else {
      if (result.errorType == ErrorType.NO_NETWORK_ERROR &&
          (state.data?.isEmpty ?? true)) {
        state = BaseState(data: [], hasNoConnection: true);
      } else {
        state = BaseState(data: state.data);
        handleError(
            errorType: result.errorType,
            errorMessage: result.errorMessage,
            keyValueErrors: result.keyValueErrors);
      }
    }
    isPerformingRequest = false;
  }

  String? validateMessage(BuildContext context, String? message, int? id,
      TextEditingController controller) {
    String? errMessgae = Validator.validateMessgae(message!) ?? null;
    print(errMessgae);
    if (errMessgae == null) {
      postMessage(context, message, id, controller);
    } else {
      return errMessgae;
    }
    return null;
  }

  Future postMessage(BuildContext context, String? message, int? id,
      TextEditingController controller) async {
    state = BaseState(data: [], isLoading: true);

    var result = await _repository.postMessage(message: message, id: id);
    print(result.data);
    if (result.data != null) {
      state = BaseState(data: [], isLoading: false);
      controller.clear();
      showToastMessage(result.data?.message ?? "");
      Navigator.pop(context);
      //resetDrawerSelection();
    } else {
      if (result.errorType == ErrorType.NO_NETWORK_ERROR &&
          (state.data ?? []).isEmpty) {
        state = BaseState(data: [], isLoading: false);
      } else {
        state = BaseState(data: [], isLoading: false);

        print("err type ${result.errorType}");
        handleError(
            errorType: result.errorType,
            errorMessage: result.errorMessage,
            keyValueErrors: result.keyValueErrors);
      }
    }
  }

  void setState(List<Message>? messages) {
    state = BaseState(data: messages, isLoading: false);
  }

  void resetState() {
    state = BaseState(data: [], isLoading: false);
  }

  void readMessage(int id) async {
    BuildContext? context = AppConstants.navigatorKey.currentContext;
    if (context != null) {
      bool userIsLoggedIn = ProviderScope.containerOf(context, listen: false)
          .read(di.userViewModelProvider.notifier)
          .isUserLoggedIn();
      BaseApiResult<ReadMessageData?> result;
      if (userIsLoggedIn) {
        if (state.data != null) {
          var index = state.data!.indexWhere((element) => element.id == id);
          List<Message> messages = state.data!;
          messages[index].isSeen = true;
          state = BaseState(data: messages);
        }
        result = await _repository.putMessageSeen(id: id);
      } else {
        var deviceState = await _repository.getOnesignalDeviceState();
        var installedAt = await _repository.installedAtTime();
        result = await _repository.putMessageSeen(
            id: id, deviceId: deviceState?.userId, installedAt: installedAt);
      }

      if (result.data != null) {
        BuildContext? context = AppConstants.navigatorKey.currentContext;
        if (context != null) {
          UserData? userData = ProviderScope.containerOf(context, listen: false)
              .read(di.userViewModelProvider);
          if (userData != null) {
            userData.notificationNotSeenCount =
                result.data?.notificationNotSeenCount;
            ProviderScope.containerOf(context, listen: false)
                .read(di.userViewModelProvider.notifier)
                .setLocalUserData(userData);
          }
          ProviderScope.containerOf(context, listen: false)
              .read(di.unseenNotificationCountProvider.notifier)
              .setLocalUnseenNotificationCount(
                  result.data?.notificationNotSeenCount ?? 0);
        }
      }
      if (state.data != null) {
        var index = state.data!.indexWhere((element) => element.id == id);
        List<Message> messages = state.data!;
        messages[index].isSeen = true;
        state = BaseState(data: messages);
      }
    }
  }

  updateState(List<Message>? messages) {
    state = BaseState(data: messages);
  }
}
