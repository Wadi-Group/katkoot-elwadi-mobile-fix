import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: AppColors.APP_BLUE,
          ),
        ),
      ),
    );
  }
}
