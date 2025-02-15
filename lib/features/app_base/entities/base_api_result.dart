import 'package:katkoot_elwady/core/constants/app_constants.dart';

class BaseApiResult<T> {
  T? data;
  final String? successMessage;
  final String? errorMessage;
  final Map<String, dynamic>? keyValueErrors;
  final ErrorType? errorType;

  BaseApiResult({
    this.data,
    this.successMessage,
    this.errorMessage,
    this.keyValueErrors,
    this.errorType,
  });
}
