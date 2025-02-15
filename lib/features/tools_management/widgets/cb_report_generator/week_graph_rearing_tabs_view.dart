import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';

class WeekGraphRearingTabsView extends StatefulWidget {
  final Function onCh1TabTap;
  final Function onCh2TabTap;

  WeekGraphRearingTabsView({
    required this.onCh1TabTap,
    required this.onCh2TabTap,
  });

  @override
  State<WeekGraphRearingTabsView> createState() =>
      _WeekGraphRearingTabsViewState();
}

class _WeekGraphRearingTabsViewState extends State<WeekGraphRearingTabsView> {
  final ValueNotifier<int> _selectedTabNotifier = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: ValueListenableBuilder<int>(
          valueListenable: _selectedTabNotifier,
          builder: (context, selected, child) {
            return Row(
              children: [
                _buildButtonView(
                    onTap: () {
                      _selectedTabNotifier.value = 1;
                      widget.onCh1TabTap();
                    },
                    title: 'ch_1_prod'.tr(),
                    selected: selected == 1),
                _buildButtonView(
                    onTap: () {
                      _selectedTabNotifier.value = 2;
                      widget.onCh2TabTap();
                    },
                    title: 'ch_2_prod'.tr(),
                    selected: selected == 2),
              ],
            );
          }),
    );
  }

  _buildButtonView({Function? onTap, String? title, bool selected = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap != null ? onTap() : null,
        child: Container(
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? 60
                : 50,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: selected
                    ? Colors.lightBlue.withOpacity(0.1)
                    : Colors.transparent),
            child: Center(
                child: CustomText(
              title: title ?? '',
              textColor: selected ? Colors.lightBlue : AppColors.Liver,
              fontWeight: FontWeight.bold,
              fontSize: context.locale.languageCode == "en" ? 14 : 12,
            ))),
      ),
    );
  }
}
