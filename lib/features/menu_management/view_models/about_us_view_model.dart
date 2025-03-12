import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';

class AboutUsViewModel extends StateNotifier<BaseState<Map<String, dynamic>?>> {
  final Repository _repository;

  AboutUsViewModel(this._repository) : super(BaseState(data: null)) {
    fetchAboutUsContent();
  }
  Future<void> fetchAboutUsContent() async {
    state = BaseState(data: state.data, isLoading: true);

    Map<String, dynamic>? result = await _repository.getAboutUs();

    if (result != null) {
      state = BaseState(data: result, isLoading: false);
    } else {
      handleError();
    }
  }

  void handleError({String? errorType, String? errorMessage}) {
    print("Error fetching About Us: \$errorType - \$errorMessage");
  }
}
