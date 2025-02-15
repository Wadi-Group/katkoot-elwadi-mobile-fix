import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/entities/bottom_navigation_state.dart';

class MainBottomNavigationViewModel extends StateNotifier<BaseState<BottomNavigationState>> {
  MainBottomNavigationViewModel() : super(BaseState(data: BottomNavigationState()));

  void setController(TabController controller){
    state.data.controller = controller;
  }

  void changeIndex(int index){
    state.data.controller?.index = index;
    state = BaseState(
        data: BottomNavigationState(
            controller: state.data.controller,
            selectedIndex: index
        )
    );
  }
}
