
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';

mixin PaginationUtils {
  int page = 1;
  bool hasNext = true;
  int limit = 10;

  bool isPerformingRequest = false;

  reset() {
    page = 1;
    hasNext = true;
  }

  checkHasNext(List li, {int? paginationLimit}) {
    hasNext = li.isNotEmpty && li.length >= (paginationLimit ?? limit);
  }

  checkPerformRequest({bool refresh = false}) {
     return isPerformingRequest || !(refresh || hasNext);
  }

  void dataState<T>(BaseState<List<T>> state, List<T>? currList) {
    state.isLoading = false;
    state.data = currList ?? [];
    state.hasNoData = currList?.isEmpty ?? false;
    state.hasNoConnection = false;
  }
}
