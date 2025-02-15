import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class CustomMessageWidget extends StatefulWidget {
  TextEditingController controller;
  CustomMessageWidget({required this.controller});

  @override
  _CustomMessageWidgetState createState() => _CustomMessageWidgetState();
}

class _CustomMessageWidgetState extends State<CustomMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height * 0.25
              : MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
              color: AppColors.APPLE_GREEN.withOpacity(0.6),
              borderRadius: BorderRadius.circular(25)),
        ),
        Positioned(
          top: 10,
          left: 0,
          right: 0,
          child: Center(
            child: CustomText(
              fontWeight: FontWeight.w500,
              title: "str_messgae".tr(),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 15),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: widget.controller,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.2
                : MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                color: AppColors.Olive_Drab.withOpacity(0.5),
                borderRadius: BorderRadius.circular(25)),
          ),
        )
      ],
    );
  }
}
