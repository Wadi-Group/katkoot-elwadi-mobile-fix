import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/utils/numbers_manager.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/tools_management/entities/parent_flock_management_broiler_state.dart';
import 'package:katkoot_elwady/features/tools_management/models/equations_results_title.dart';

class ParentFlockManagementBroilerResultsView extends StatelessWidget {
  final ParentFlockManagementBroilerState? broilerData;
  final EquationsResultTitle? resultTitle;

  ParentFlockManagementBroilerResultsView(
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
                  key: resultTitle?.broilersPerYear ?? '',
                  value: NumbersManager.getThousandFormat(
                      broilerData?.broilersPerYear ?? 0)),
              _buildResultItem(
                  key: resultTitle?.chickenPlacedBeforeDeath ?? '',
                  value: NumbersManager.getThousandFormat(
                      broilerData?.chickenPlacedBeforeDeath ?? 0)),
              _buildResultItem(
                  key: resultTitle?.placedEggs ?? '',
                  value: NumbersManager.getThousandFormat(
                      broilerData?.placedEggs ?? 0)),
              _buildResultItem(
                  key: resultTitle?.hen ?? '',
                  value:
                      NumbersManager.getThousandFormat(broilerData?.hen ?? 0)),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _buildResultItem(
            key: resultTitle?.pullets ?? '',
            value: NumbersManager.getThousandFormat(broilerData?.pullets ?? 0),
            titleFontSize: 20),
      ],
    );
  }

  _buildResultItem(
      {required String? key, required String? value, double? titleFontSize}) {
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
                  title: 'per_year'.tr(),
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
