import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import '../../app_base/widgets/custom_text.dart';
import '../widgets/reusable_container_widget.dart';

class WeatherAndPricesSection extends StatelessWidget {
  final String city;
  final String date;
  final String weather;
  final String liveBroilersPrice;
  final String eggTrayPrice;
  final String katkootPrice;

  const WeatherAndPricesSection({
    Key? key,
    required this.city,
    required this.date,
    required this.weather,
    required this.liveBroilersPrice,
    required this.eggTrayPrice,
    required this.katkootPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Column: Weather & Prices
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildWeatherInfo(),
              SizedBox(height: 30),
              _buildPriceCard(
                title: "live_broilers".tr(),
                price: liveBroilersPrice,
                unit: "egp_kg".tr(),
                imagePath: "assets/images/live_broilers.png",
              ),
              SizedBox(height: 10),
              _buildPriceCard(
                title: "egg_tray".tr(),
                price: eggTrayPrice,
                unit: "egp".tr(),
                imagePath: "assets/images/egg_tray.png",
                isBottomRounded: true,
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        // Right Side: Katkoot Al Wadi Broiler Price
        _buildKatkootPrice(context),
      ],
    );
  }

  /// Weather Info Widget
  Widget _buildWeatherInfo() {
    return ReusableContainer(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      boxShadow: [_buildShadow()],
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CustomText(
                  title: "🌤${double.tryParse(weather)?.ceil() ?? ''}°",
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.APP_BLUE,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Image.asset(
                  "assets/images/location.png",
                  width: 20,
                  height: 20,
                  color: AppColors.APP_BLUE,
                ),
                SizedBox(width: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: date,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.APP_BLUE,
                    ),
                    CustomText(
                      title: city,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.APP_BLUE,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Price Card Widget
  Widget _buildPriceCard({
    required String title,
    required String price,
    required String unit,
    required String imagePath,
    bool isBottomRounded = false,
  }) {
    return ReusableContainer(
      boxShadow: [_buildShadow()],
      padding: EdgeInsets.symmetric(horizontal: 10),
      borderRadius: BorderRadius.vertical(
        top: isBottomRounded ? Radius.zero : Radius.circular(20),
        bottom: isBottomRounded ? Radius.circular(20) : Radius.zero,
      ),
      height: 50,
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 20,
            height: 20,
            color: AppColors.APP_BLUE,
          ),
          SizedBox(width: 5),
          CustomText(
            title: title,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            textColor: AppColors.APP_BLUE,
          ),
          Spacer(),
          _buildPriceText(price, unit),
        ],
      ),
    );
  }

  /// Katkoot Al Wadi Broiler Price Widget
  Widget _buildKatkootPrice(BuildContext context) {
    return Flexible(
      child: ReusableContainer(
        padding: EdgeInsets.symmetric(horizontal: 10),
        borderRadius: context.locale.languageCode == "en"
            ? BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(20),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
        boxShadow: [_buildShadow()],
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/katkot_broilers.png",
              width: 30,
              height: 30,
              color: AppColors.APP_BLUE,
            ),
            SizedBox(height: 10),
            CustomText(
              title: "katkot_alwadi_broilers_doc_price".tr(),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              textColor: AppColors.APP_BLUE,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            _buildPriceText(katkootPrice, "egp".tr()),
          ],
        ),
      ),
    );
  }

  /// Price Text Widget
  Widget _buildPriceText(String price, String unit) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.APPLE_GREEN,
            ),
          ),
          TextSpan(
            text: "  $unit",
            style: TextStyle(
              fontSize: 10,
              color: AppColors.APPLE_GREEN,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Box Shadow
  BoxShadow _buildShadow() {
    return BoxShadow(
      color: AppColors.APP_CARDS_BLUE.withAlpha(25),
      spreadRadius: 0.5,
      blurRadius: 2,
      offset: Offset(1, 2),
    );
  }
}
