import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/utils/numbers_manager.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/tools_management/entities/parent_flock_management_pullets_state.dart';
import 'package:katkoot_elwady/features/tools_management/models/equations_result_title.dart';

class ParentFlockManagementPulletsResultsView extends StatelessWidget {
  final ParentFlockManagementPulletsState? broilerData;
  final EquationsResultTitle? resultTitle;

  ParentFlockManagementPulletsResultsView(
      {required this.broilerData, required this.resultTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.Light_Tea_green,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              _buildResultItem(
                  key: resultTitle?.hen ?? '',
                  value: NumbersManager.getThousandFormat(
                      broilerData?.placedHens ?? 0)),
              _buildResultItem(
                  key: resultTitle?.placedEggs ?? '',
                  value: NumbersManager.getThousandFormat(
                      broilerData?.eggsPlaced ?? 0)),
              _buildResultItem(
                  key: resultTitle?.hatchingEggs ?? '',
                  value: NumbersManager.getThousandFormat(
                      broilerData?.hatchingEggs ?? 0)),
              _buildResultItem(
                  key: resultTitle?.broilersPerYear ?? '',
                  value: NumbersManager.getThousandFormat(
                      broilerData?.broilersPerYear ?? 0)),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        _buildResultItem(
            key: 'broiler'.tr(),
            unit: 'per_week'.tr(),
            value: NumbersManager.getThousandFormat(
                broilerData?.broilersPerWeek ?? 0),
            titleFontSize: 20),
      ],
    );
  }

  _buildResultItem(
      {required String? key,
      required String? value,
      String? unit,
      double? titleFontSize}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: key ?? '',
                  fontSize: titleFontSize ?? 16,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.Liver,
                ),
                CustomText(
                  title: unit ?? 'per_year'.tr(),
                  fontSize: 12,
                  italic: true,
                  textColor: AppColors.Liver,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomText(
              title: value ?? '',
              fontSize: 16,
              textColor: AppColors.Liver,
            ),
          ),
        ],
      ),
    );
  }
}
