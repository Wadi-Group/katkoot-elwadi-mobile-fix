import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/core/services/repository.dart';
import 'package:riverpod/riverpod.dart';

import '../entities/slider_item.dart';

class CustomSliderViewModel extends StateNotifier<BaseState<SliderItem>> with BaseViewModel {
  Repository _repository;

  CustomSliderViewModel(this._repository) : super(BaseState(data: SliderItem(duration: "" ,sliderIcons: [],sliderIntervals: []))) ;

  initSlider(SliderItem item) {
    this.state = BaseState(data: item);

  }


  updateSliderWidget(double  position){
    SliderItem sliderItem = this.state.data;
    sliderItem.current = position;
    this.state = BaseState(data: sliderItem);
  }

}
