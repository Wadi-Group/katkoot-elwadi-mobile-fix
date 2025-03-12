import 'dart:io';

import 'package:dio/dio.dart';
import 'package:katkoot_elwady/core/api/api_config.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_api_result.dart';
import 'package:katkoot_elwady/features/app_base/models/base_list_response.dart';
import 'package:katkoot_elwady/features/app_base/models/base_response.dart';

class ApiMethods<T> {
  // get request without baseApiResult wrapper
  Future<T> getRaw(String url,
      {Map<String, String>? params,
      bool hasToken = true,
      bool hasLanguage = true,
      bool cache = false}) async {
    Response response = await ApiConfig.dio.get(url,
        queryParameters: params,
        options: getOptions(
            cache: cache, hasToken: hasToken, hasLanguage: hasLanguage));
    print(response.toString());
    return response.data;
  }

  Future<BaseApiResult<T>> get(String url,
      {Map<String, String>? params,
      bool hasToken = true,
      bool hasLanguage = true,
      bool cache = false}) async {
    try {
      Response response = await ApiConfig.dio.get(url,
          queryParameters: params,
          options: getOptions(
              cache: cache, hasToken: hasToken, hasLanguage: hasLanguage));
      print(response.toString());
      return _handleResponse(response);
    } on DioException catch (error) {
      return _catchError<T>(error);
    }
  }

  Future<BaseApiResult<List<T>>> getList(String url,
      {Map<String, String>? params,
      bool hasToken = true,
      bool cache = false}) async {
    try {
      Response response = await ApiConfig.dio.get(url,
          queryParameters: params,
          options: getOptions(cache: cache, hasToken: hasToken));
      print(response.toString());
      return _handleResponseList(response);
    } on DioException catch (error) {
      print(error);
      return _catchError<List<T>>(error);
    }
  }

  Future<BaseApiResult<T>> post(String url,
      {Map<String, dynamic>? data,
      bool hasToken = true,
      bool hasLanguage = true,
      bool cache = false}) async {
    try {
      print(url);
      print('${data.toString()}');
      Response response = await ApiConfig.dio.post(url,
          data: data,
          options: getOptions(
              cache: cache, hasToken: hasToken, hasLanguage: hasLanguage));

      print('${response.toString()}');
      return _handleResponse(response);
    } on DioException catch (error) {
      return _catchError(error);
    }
  }

  Future<BaseApiResult<List<T>>> postWithListResponse(String url,
      {Map<String, dynamic>? data,
      bool hasToken = true,
      bool hasLanguage = true,
      bool cache = false}) async {
    try {
      print(url);
      print('${data.toString()}');
      Response response = await ApiConfig.dio.post(url,
          data: data,
          options: getOptions(
              cache: cache, hasToken: hasToken, hasLanguage: hasLanguage));

      print('${response.toString()}');
      return _handleResponseList(response);
    } on DioException catch (error) {
      return _catchError(error);
    }
  }

  Future<BaseApiResult<T>> delete(String url,
      {Map<String, dynamic>? data,
      bool hasToken = true,
      bool hasLanguage = true,
      bool cache = false}) async {
    try {
      print(url);
      print('${data.toString()}');
      Response response = await ApiConfig.dio.delete(url,
          data: data,
          options: getOptions(
              cache: cache, hasToken: hasToken, hasLanguage: hasLanguage));

      print('${response.toString()}');
      return _handleResponse(response);
    } on DioException catch (error) {
      return _catchError(error);
    }
  }

  Future<BaseApiResult<T>> put(String url,
      {Map<String, dynamic>? data,
      bool hasToken = true,
      bool hasLanguage = true,
      bool cache = false}) async {
    try {
      print(url);
      print('${data.toString()}');
      Response response = await ApiConfig.dio.put(url,
          data: data,
          options: getOptions(
              cache: cache, hasToken: hasToken, hasLanguage: hasLanguage));
      print(response);
      return _handleResponse(response);
    } on DioException catch (error) {
      return _catchError(error);
    }
  }

  Future<BaseApiResult<T>> postWithFormData(String url,
      {required FormData data,
      bool hasToken = true,
      bool cache = false}) async {
    try {
      Response response = await ApiConfig.dio.post(url,
          data: data, options: getOptions(cache: cache, hasToken: hasToken));

      print(response.toString());
      return _handleResponse(response);
    } on DioException catch (error) {
      return _catchError(error);
    }
  }

  Future<BaseApiResult<T>> downloadFile(String uri, String path) async {
    print(uri);
    try {
      await ApiConfig.downloadDio.download(
        uri,
        path,
        onReceiveProgress: (rcv, total) {
          print('completed: ${rcv / total * 100}');
        },
        deleteOnError: true,
      );

      return BaseApiResult<T>(data: File(path) as T);
    } on DioException catch (error) {
      return _catchError(error);
    }
  }

  Options getOptions(
      {bool cache = false, bool hasToken = true, bool hasLanguage = true}) {
    Map<String, dynamic>? headers = {
      "accept": "application/json",
      hasToken ? 'Authorization' : 'token': "",
    };
    var options = Options(headers: headers, extra: {'Language': hasLanguage});
    return options;
  }

  BaseApiResult<List<T>> _handleResponseList(Response response) {
    var responseData = response.data;
    if (responseData == null) {
      return BaseApiResult<List<T>>(errorType: ErrorType.GENERAL_ERROR);
    }
    BaseListResponse<T> baseResponse =
        BaseListResponse<T>.fromJson(responseData);
    return BaseApiResult<List<T>>(
        data: baseResponse.data?.items, successMessage: baseResponse.message);
  }

  BaseApiResult<T> _handleResponse(Response response) {
    var responseData = response.data;

    if (responseData == null) {
      return BaseApiResult<T>(errorType: ErrorType.GENERAL_ERROR);
    }

    BaseResponse<T> baseResponse = BaseResponse<T>.fromJson(responseData);

    return BaseApiResult<T>(
        data: baseResponse.data, successMessage: baseResponse.message);
  }

  BaseApiResult<E> _catchError<E>(DioException dioError) {
    if (dioError == DioExceptionType.badResponse) {
      return _handleApiErrors(dioError);
    } else {
      return _handleDioErrors(dioError);
    }
  }

  BaseApiResult<E> _handleDioErrors<E>(DioException dioError) {
    print(dioError.toString());
    if (dioError == DioExceptionType.connectionTimeout) {
      return BaseApiResult<E>(errorType: ErrorType.NO_NETWORK_ERROR);
    } else if (dioError.type == DioExceptionType.receiveTimeout) {
      return BaseApiResult<E>(errorType: ErrorType.NO_NETWORK_ERROR);
    } else if (dioError.type == DioExceptionType.sendTimeout) {
      return BaseApiResult<E>(errorType: ErrorType.NO_NETWORK_ERROR);
    } else if (dioError.type == DioExceptionType.cancel) {
      return BaseApiResult<E>(errorType: ErrorType.GENERAL_ERROR);
    } else if (dioError.type == DioExceptionType.unknown) {
      return BaseApiResult<E>(errorType: ErrorType.GENERAL_ERROR);
    } else {
      return BaseApiResult<E>(errorType: ErrorType.GENERAL_ERROR);
    }
  }

  BaseApiResult<E> _handleApiErrors<E>(DioException dioError) {
    print(dioError.response.toString());
    var responseData = dioError.response?.data;
    if (responseData == null) {
      return BaseApiResult<E>(errorType: ErrorType.GENERAL_ERROR);
    }
    BaseResponse<E> baseResponse = BaseResponse<E>.fromJson(responseData);

    print(dioError.response?.statusCode.toString());
    switch (dioError.response?.statusCode) {
      case AppConstants.UNAUTHORIZED_ERROR:
        print(baseResponse.message);
        return BaseApiResult<E>(
            keyValueErrors: baseResponse.errors,
            errorType: ErrorType.UNAUTHORIZED_ERROR,
            errorMessage: baseResponse.message);
      case AppConstants.VALIDATION_ERROR:
        return BaseApiResult<E>(
            errorMessage: baseResponse.message,
            keyValueErrors: baseResponse.errors);
      case AppConstants.ACTION_DENIED:
        return BaseApiResult<E>(
            errorMessage: baseResponse.message,
            keyValueErrors: baseResponse.errors);
      case AppConstants.NOT_FOUND:
        return BaseApiResult<E>(
            errorMessage: baseResponse.message,
            keyValueErrors: baseResponse.errors);
      case AppConstants.SERVER_ERROR:
        return BaseApiResult<E>(errorType: ErrorType.GENERAL_ERROR);
      default:
        return BaseApiResult<E>(errorType: ErrorType.GENERAL_ERROR);
    }
  }
}
