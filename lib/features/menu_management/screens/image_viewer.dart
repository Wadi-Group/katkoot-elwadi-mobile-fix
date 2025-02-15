import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/photo_hero.dart';

class ImageViewer extends StatelessWidget {
  String imagePath;
  ImageViewer({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  AppConstants.navigatorKey.currentState?.pop();
                },
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Hero(
                          tag: imagePath,
                          child: GestureDetector(
                            onTap: (){
                              // print("close");
                            },
                            child: Image.network(
                              imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            PositionedDirectional(
              top: 5,
              end: 0,
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                      onPressed: () {
                        AppConstants.navigatorKey.currentState?.pop();
                      },
                      icon: Container(
                        padding: EdgeInsetsDirectional.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.Pastel_gray.withOpacity(0.5)),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
