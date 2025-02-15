import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class ToolsFlexibleAppBar extends StatelessWidget {
  final String backgroundTitle;
  final String title;

  const ToolsFlexibleAppBar({
    Key? key,
    required this.backgroundTitle,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlexibleSpaceBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
                end: 10,
                start:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 20
                        : 0),
            child: Text(
              title,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        stretchModes: [StretchMode.fadeTitle],
        centerTitle: false,
        background: Align(
            alignment:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? AlignmentDirectional.centerStart
                    : AlignmentDirectional.topStart,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  start:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 72
                          : 100,
                  end: 72,
                  top:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 0
                          : 20),
              child: Container(
                margin: EdgeInsetsDirectional.only(bottom: 10),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    title: backgroundTitle,
                    textColor: Colors.white,
                    maxLines: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: title.length > 25 ? 12 : 18,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
