import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/guides_management/models/video.dart';

class MenuCategorizedVideosViewModel
    extends StateNotifier<BaseState<CategorizedVideosState>>
    with BaseViewModel {
  final Repository _repository;

  MenuCategorizedVideosViewModel(this._repository)
      : super(BaseState(data: CategorizedVideosState()));

  Future getVideos({String? searchText}) async {
    // Set state to loading
    state = BaseState(data: CategorizedVideosState.loading());

    try {
      // Fetch categories and latest videos in parallel
      var results = await Future.wait([
        _repository.getCategorizedVideos(),
        _repository.getCategoryVideos(limit: 6),
      ]);

      var categoryResult = results[0];
      var latestVideosResult = results[1];

      if (categoryResult.data != null && latestVideosResult.data != null) {
        List<Category> categories =
            (categoryResult.data as List).cast<Category>();
        ;
        List<Video> latestVideos =
            (latestVideosResult.data as List).cast<Video>();

        // Update state with both categories and videos
        state = BaseState(
          data: CategorizedVideosState(
            categories: categories,
            videos: latestVideos,
            hasNoData: categories.isEmpty && latestVideos.isEmpty,
          ),
        );
      } else {
        // Handle errors
        bool noConnection =
            categoryResult.errorType == ErrorType.NO_NETWORK_ERROR ||
                latestVideosResult.errorType == ErrorType.NO_NETWORK_ERROR;

        state = BaseState(
            data: CategorizedVideosState.error(noConnection: noConnection));

        handleError(
          errorType: categoryResult.errorType ?? latestVideosResult.errorType,
          errorMessage:
              categoryResult.errorMessage ?? latestVideosResult.errorMessage,
          keyValueErrors: categoryResult.keyValueErrors ??
              latestVideosResult.keyValueErrors,
        );
      }
    } catch (e) {
      state = BaseState(data: CategorizedVideosState.error());
      print("Error fetching videos: $e");
    }
  }
}

class CategorizedVideosState {
  final List<Category>? categories;
  final List<Video>? videos;
  final bool isLoading;
  final bool hasNoData;
  final bool hasNoConnection;

  CategorizedVideosState({
    this.categories,
    this.videos,
    this.isLoading = false,
    this.hasNoData = false,
    this.hasNoConnection = false,
  });

  // Factory method to create a loading state
  factory CategorizedVideosState.loading() =>
      CategorizedVideosState(isLoading: true);

  // Factory method to create an error state
  factory CategorizedVideosState.error({bool noConnection = false}) =>
      CategorizedVideosState(
        hasNoConnection: noConnection,
        hasNoData: true,
      );
}
