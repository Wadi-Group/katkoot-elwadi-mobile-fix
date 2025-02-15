import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class ChangeLanguageWidget extends StatelessWidget {
  final String value;
  final String groupValue;
  final Function onChanged;
  final String title;
  final String imagePath;

  ChangeLanguageWidget(
      {required this.title,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    var isSelected = groupValue == value;
    return GestureDetector(
      onTap: () => onChanged(),
      child: Container(
        width: 180,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? AppColors.Tea_green : AppColors.LIGHT_GREY,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: isSelected ? AppColors.Tea_green : AppColors.white
              ),


                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // Radio(
                    //   value: value,
                    //   groupValue: groupValue,
                    //   onChanged: (value) {
                    //     onChanged();
                    //   },
                    //   activeColor: AppColors.Liver,
                    // ),
                    Image.asset(
                      imagePath,
                      height: 16,
                      width: 16,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomText(
                        textColor: AppColors.Liver,
                        title: title,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: value == 'en' ? 'Arial' : 'GE_SS_Two',),

                  ],
                ),


          ),
    );


    //     SizedBox(
    //       height: 5,
    //     ),
    //
    //   ],
    // );
  }
}
