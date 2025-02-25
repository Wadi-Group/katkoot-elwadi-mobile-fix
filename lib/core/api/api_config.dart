import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/api/api_urls.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/user_management/models/user_data.dart';

import '../di/injection_container.dart' as di;

const String DONT_INTERCEPT_KEY = "DONT_INTERCEPT_KEY";

class ApiConfig {
  static Dio dio = createDio();

  static final Dio _refreshDio = Dio(BaseOptions(
      connectTimeout: Duration(milliseconds: 60000),
      receiveTimeout: Duration(milliseconds: 60000),
      baseUrl: ApiUrls.BASE_URL));

  static Dio downloadDio = Dio();

  static Dio createDio() {
    return Dio(BaseOptions(
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000),
        baseUrl: ApiUrls.BASE_URL))
      ..interceptors.addAll([AppInterceptor()]);
  }
}

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('on request ${_userData?.token}');
    if (!(options.extra[DONT_INTERCEPT_KEY] ?? false)) {
      if (options.extra["Language"] ?? false) {
        options.path =
            '${AppConstants.navigatorKey.currentContext?.locale.toString()}/${options.path}';
      }
      if (options.headers.containsKey('Authorization')) {
        options.headers['Authorization'] = 'Bearer ${_userData?.token}';
      }
    }
    print(options.uri.toString());
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException dioError, ErrorInterceptorHandler handler) {
    print('on error ${dioError.type.toString()}');
    var dontIntercept =
        dioError.response?.requestOptions.extra[DONT_INTERCEPT_KEY] ?? false;
    if (dioError.type == DioExceptionType.badResponse) {
      if (dioError.response?.statusCode == AppConstants.UNAUTHORIZED_ERROR &&
          dioError.requestOptions.headers.containsKey('Authorization')) {
        if (!dontIntercept) {
          _refreshToken(dioError, handler);
        } else {
          handler.reject(dioError);
        }
        return;
      }
    } else if (dioError.error is SocketException) {
      dioError = DioException(requestOptions: RequestOptions());
    }
    super.onError(dioError, handler);
  }

  _refreshToken(DioException dioError, ErrorInterceptorHandler handler) async {
    // ApiConfig.dio.interceptors.requestLock.lock();
    // ApiConfig.dio.interceptors.responseLock.lock();

    try {
      var res = await ApiConfig._refreshDio.post(ApiUrls.REFRESH_TOKEN, data: {
        "refresh_token": _userData?.token,
      });
      var data = res.data['data'];
      if (data == null) {
        handler.reject(dioError);
        return;
      }
      _userData?.token = data['token'];
      ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
              listen: false)
          .read(di.userViewModelProvider.notifier)
          .setLocalUserData(_userData);

      print('refreshtoken');
      // ApiConfig.dio.interceptors.requestLock.unlock();
      // ApiConfig.dio.interceptors.responseLock.unlock();
      var options = dioError.response!.requestOptions;
      Response response = await ApiConfig.dio.request(options.path,
          data: options.data,
          options: Options(method: options.method, headers: {
            ...options.headers,
            "Authorization": "Bearer ${data['token']}",
          }, extra: {
            DONT_INTERCEPT_KEY: true
          }));
      handler.resolve(response);
    } on DioException catch (error) {
      print('catch error');
      // ApiConfig.dio.interceptors.requestLock.unlock();
      // ApiConfig.dio.interceptors.responseLock.unlock();
      if (dioError.type == DioExceptionType.badResponse) {
        if (dioError.response?.statusCode == AppConstants.UNAUTHORIZED_ERROR &&
            dioError.requestOptions.headers.containsKey('Authorization')) {
          handler.reject(error);
          return;
        }
      }
      handler.next(error);
    }
  }

  static UserData? get _userData =>
      ProviderScope.containerOf(AppConstants.navigatorKey.currentContext!,
              listen: false)
          .read(di.userViewModelProvider);
}
