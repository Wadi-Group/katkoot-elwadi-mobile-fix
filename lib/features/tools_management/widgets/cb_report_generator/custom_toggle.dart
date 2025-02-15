import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';

class ToggleButton extends StatefulWidget {
  Function onToggle;
  ToggleCases intialCase;
  ToggleButton({required this.onToggle, required this.intialCase});
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  double width = 80.0;
  double height = 40.0;
  double loginAlign = -1;
  double signInAlign = 1;
  String rearingIcon = "assets/images/8_weeks_g.png";
  String productionIcon = "assets/images/15_weeks_g.png";
  double? xAlign;
  ToggleCases? toggleCase;

  @override
  void initState() {
    super.initState();
    toggleCase = widget.intialCase;
    xAlign = loginAlign;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(1, 0),
            duration: Duration(milliseconds: 300),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: AppColors.Mansuel,
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (widget.onToggle() != null) {
                  xAlign = loginAlign;

                  toggleCase = ToggleCases.REARING;
                }
              });
            },
            child: Align(
              alignment:
                  Alignment(toggleCase == ToggleCases.REARING ? -2 : -1, 0),
              child: Container(
                margin: EdgeInsets.all(5),
                width: toggleCase == ToggleCases.REARING ? 50 : width / 2,
                decoration: BoxDecoration(
                  color: toggleCase == ToggleCases.REARING
                      ? AppColors.Snow
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                alignment: Alignment.center,
                child: ImageIcon(
                  AssetImage(rearingIcon),
                  size: 20,
                  color: toggleCase == ToggleCases.REARING
                      ? AppColors.ORANGE
                      : AppColors.Platinum,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (widget.onToggle() != null) {
                  xAlign = signInAlign;
                  toggleCase = ToggleCases.PRODUCTION;
                }
              });
            },
            child: Align(
              alignment:
                  Alignment(toggleCase == ToggleCases.PRODUCTION ? 2 : 1, 0),
              child: Container(
                margin: EdgeInsets.all(5),
                width: toggleCase == ToggleCases.PRODUCTION ? 50 : width / 2,
                decoration: BoxDecoration(
                  color: toggleCase == ToggleCases.PRODUCTION
                      ? AppColors.Snow
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                alignment: Alignment.center,
                child: ImageIcon(
                  AssetImage(productionIcon),
                  size: 20,
                  color: toggleCase == ToggleCases.PRODUCTION
                      ? AppColors.Dark_spring_green
                      : AppColors.Platinum,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ToggleCases { REARING, PRODUCTION }
