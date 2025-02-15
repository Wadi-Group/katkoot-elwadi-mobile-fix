import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';

import '../../app_base/widgets/custom_text.dart';
import '../widgets/reusable_container_widget.dart';

class AlafAlWadiPrices extends StatelessWidget {
  final List<Map<String, String>> prices;
  AlafAlWadiPrices({
    Key? key,
    required this.prices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomText(
            title: "alaf_alwadi_price".tr(),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            textColor: AppColors.APP_BLUE,
          ),
        ),
        SizedBox(height: 20),
        ReusableContainer(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(prices.length * 2 - 1, (index) {
              if (index.isOdd) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 2,
                  height: 50,
                  color: Colors.grey[300], // Vertical Divider
                );
              }
              final item = prices[index ~/ 2];
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Centered Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          item["image"]!,
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: CustomText(
                            title: item["title"]!,
                            fontSize: 14,
                            maxLines: 2,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.start,
                            textColor: AppColors.APP_BLUE,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    RichText(
                      textAlign: TextAlign.center, // Center price text
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: item["price"]!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.APPLE_GREEN,
                            ),
                          ),
                          TextSpan(
                            text: " ${"egp_ton".tr()}",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.APPLE_GREEN,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
