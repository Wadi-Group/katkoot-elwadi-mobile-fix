import 'package:flutter/material.dart';
import 'package:katkoot_elwady/features/app_base/widgets/tabbar/tabbar_data.dart';

class TabBarItem extends StatelessWidget {
  final TabbarData data;
  final Animation<double> animation;
  const TabBarItem({
    Key? key,
    required this.data,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      margin: data.isFromSearchAppBar
          ? null
          : EdgeInsets.symmetric(
              horizontal: 10,
            ),
      height: 40,
      child: Stack(
        children: [
          if (data.activeWidget != null)
            Positioned.fill(
                child: FadeTransition(
              opacity: animation,
              child: data.isFromSearchAppBar
                  ? data.activeWidget
                  : Center(child: data.activeWidget),
            )),
          Positioned.fill(
            child: data.activeWidget != null
                ? FadeTransition(
                    opacity: animation.drive(Tween<double>(begin: 1, end: 0)),
                    child: Center(child: data.inActiveWidget),
                  )
                : Center(child: data.inActiveWidget),
          ),
        ],
      ),
    );
  }
}
