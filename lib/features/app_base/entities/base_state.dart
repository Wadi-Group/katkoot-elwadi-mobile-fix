class BaseState<T> {
  bool isLoading;
  bool isPerformingRequest;
  String successMessage;
  bool hasNoConnection;
  bool noConnectionHasBackground;
  bool hasNoData;
  String noDataMessage;
  T data;

  BaseState(
      {this.isLoading = false,
      this.isPerformingRequest = false,
      this.successMessage = '',
      this.hasNoConnection = false,
      this.noConnectionHasBackground = false,
      this.hasNoData = false,
      this.noDataMessage = "",
      required this.data});
}
