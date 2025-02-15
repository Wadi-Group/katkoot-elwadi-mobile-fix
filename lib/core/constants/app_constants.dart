import 'package:flutter/material.dart';

class AppConstants {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static const int SUCCESS = 200;
  static const int UNAUTHORIZED_ERROR = 401;
  static const int VALIDATION_ERROR = 422;
  static const int ACTION_DENIED = 403;
  static const int INVALID_TOKEN_ERROR = 400;
  static const int NOT_FOUND = 404;
  static const int SERVER_ERROR = 500;
  static const String YOUTUBE_PROVIDER = "youtube";
  static const int MAIN_CATEGORIES = 1;
  static const int ALL_CATEGORIES = 0;

  static const int REARING_MIN_VALUE = 1;
  static const int REARING_MAX_VALUE = 24;
  static const int PRODUCTION_MIN_VALUE = 25;
  static const int PRODUCTION_MAX_VALUE = 64;

  static const ONESIGNAL_APP_ID = "860de95b-d3ef-4edd-94a3-c42635eaf806";
}

enum ErrorType {
  NO_NETWORK_ERROR,
  GENERAL_ERROR,
  UNAUTHORIZED_ERROR
}
