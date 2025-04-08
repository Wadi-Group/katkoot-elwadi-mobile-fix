import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class CustomMessageWidget extends StatefulWidget {
  final TextEditingController controller;

  CustomMessageWidget({required this.controller});

  @override
  _CustomMessageWidgetState createState() => _CustomMessageWidgetState();
}

class _CustomMessageWidgetState extends State<CustomMessageWidget> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final heightFactor = isPortrait ? 0.25 : 0.5;

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * heightFactor,
          decoration: BoxDecoration(
            color: AppColors.APPLE_GREEN.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        Positioned(
          top: 16,
          left: 0,
          right: 0,
          child: Center(
            child: CustomText(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              title: "str_messgae".tr(),
              textColor: AppColors.APP_BLUE,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height:
                MediaQuery.of(context).size.height * (isPortrait ? 0.18 : 0.35),
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: TextField(
              controller: widget.controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: 16, color: Colors.black87),
              decoration: InputDecoration.collapsed(
                hintText: "type_your_message".tr(),
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
