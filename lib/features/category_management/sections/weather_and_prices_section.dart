import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/services/remote/weather_service.dart';
import 'package:katkoot_elwady/core/utils/numbers_manager.dart';
import '../../app_base/widgets/custom_text.dart';
import '../widgets/reusable_container_widget.dart';

class WeatherAndPricesSection extends StatelessWidget {
  final String? city;
  final String? date;
  final String? weather;
  final String? liveBroilersPrice;
  final String? whiteEggTrayPrice;
  final String? brownEggTrayPrice;
  final String? katkootPrice;

  const WeatherAndPricesSection({
    Key? key,
    this.city,
    this.date,
    this.weather,
    this.liveBroilersPrice,
    this.whiteEggTrayPrice,
    this.katkootPrice,
    this.brownEggTrayPrice,
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
              _buildWeatherInfo(context),
              SizedBox(height: 20),
              _buildPriceCard(
                isImageWhite: true,
                title: "live_broilers".tr(),
                price: liveBroilersPrice ?? "N/A",
                unit: "egp_kg".tr(),
                imagePath: "assets/images/live_broilers.png",
                isTopRounded: true,
                context: context,
              ),
              SizedBox(height: 15),
              _buildPriceCard(
                height: 35,
                title: "white_egg_tray".tr(),
                price: whiteEggTrayPrice ?? "N/A",
                unit: "egp".tr(),
                imagePath: "assets/images/white_egg_tray.png",
                isBottomRounded: false,
                context: context,
              ),
              _buildPriceCard(
                height: 35,
                title: "brown_egg_tray".tr(),
                price: brownEggTrayPrice ?? "N/A",
                unit: "egp".tr(),
                imagePath: "assets/images/red_egg_tray.png",
                isBottomRounded: true,
                context: context,
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
  Widget _buildWeatherInfo(BuildContext context) {
    return ReusableContainer(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      boxShadow: [_buildShadow()],
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CustomText(
                title: (weather?.isEmpty ?? true)
                    ? "🌤 N/A"
                    : context.locale.languageCode == "ar"
                        ? NumbersManager.convertEnglishNumbersToArabic(
                            "🌤${double.tryParse(weather ?? "0")?.ceil() ?? ''}°")
                        : "🌤${double.tryParse(weather ?? "0")?.ceil() ?? ''}°",
                fontSize: 22,
                fontWeight: FontWeight.w400,
                textColor: AppColors.APP_BLUE,
              ),
            ],
          ),
          SizedBox(width: 10),
          Expanded(
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
                      title: (date?.isEmpty ?? true)
                          ? (context.locale.languageCode == "ar"
                              ? NumbersManager.convertEnglishNumbersToArabic(
                                  WeatherService.getCurrentDate(context))
                              : WeatherService.getCurrentDate(context))
                          : (context.locale.languageCode == "ar"
                              ? NumbersManager.convertEnglishNumbersToArabic(
                                  date ?? '')
                              : date ?? ''),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.APP_BLUE,
                    ),
                    SizedBox(height: 5),
                    CustomText(
                      title: (city?.isEmpty ?? true)
                          ? "cairo_str".tr()
                          : city ?? 'cairo_str'.tr(),
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
    bool? isImageWhite = false,
    bool isBottomRounded = false,
    bool isTopRounded = false,
    double? height,
    required BuildContext context,
  }) {
    return ReusableContainer(
      boxShadow: [_buildShadow()],
      padding: EdgeInsets.symmetric(horizontal: 10),
      borderRadius: BorderRadius.vertical(
        top: isTopRounded ? Radius.circular(20) : Radius.zero,
        bottom: isBottomRounded ? Radius.circular(20) : Radius.zero,
      ),
      height: height ?? 50,
      child: Row(
        children: [
          Transform.flip(
            flipX: context.locale.languageCode == "ar" ? true : false,
            child: Image.asset(
              imagePath,
              width: 25,
              height: 20,
              color: isImageWhite ?? false ? AppColors.APP_BLUE : null,
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: CustomText(
              title: title,
              fontSize: 12,
              maxLines: 2,
              fontWeight: FontWeight.w700,
              textColor: AppColors.APP_BLUE,
            ),
          ),
          SizedBox(width: 5),
          _buildPriceText(price, unit, context),
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
        height: 215,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.flip(
              flipX: context.locale.languageCode == "ar" ? false : true,
              child: Image.asset(
                "assets/images/katkot_broilers.png",
                width: 30,
                height: 30,
                color: AppColors.APP_BLUE,
              ),
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
            _buildPriceText(katkootPrice ?? "N/A", "egp".tr(), context),
          ],
        ),
      ),
    );
  }

  /// Price Text Widget
  Widget _buildPriceText(String price, String unit, BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: context.locale.languageCode == "ar"
                ? NumbersManager.convertEnglishNumbersToArabic(price)
                : price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.GreenColor,
              fontFamily:
                  context.locale.languageCode == "ar" ? 'Almarai' : 'Arial',
            ),
          ),
          TextSpan(
            text: "  $unit",
            style: TextStyle(
              fontSize: 10,
              color: AppColors.GreenColor,
              fontWeight: FontWeight.w500,
              fontFamily:
                  context.locale.languageCode == "ar" ? 'Almarai' : 'Arial',
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
