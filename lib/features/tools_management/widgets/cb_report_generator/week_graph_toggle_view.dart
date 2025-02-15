import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

class WeekGraphsToggleView extends StatefulWidget {
  final Function onFirstTabTap;
  final Function onSecondTabTap;
  final String? firstTabTitle;
  final String? secondTabTitle;

  WeekGraphsToggleView({
    required this.onFirstTabTap,
    required this.onSecondTabTap,
    required this.firstTabTitle,
    required this.secondTabTitle,
  });

  @override
  State<WeekGraphsToggleView> createState() => _WeekGraphsToggleViewState();
}

class _WeekGraphsToggleViewState extends State<WeekGraphsToggleView> {
  final ValueNotifier<int> _selectedTabNotifier = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width * 0.8,
      child: ValueListenableBuilder<int>(
          valueListenable: _selectedTabNotifier,
          builder: (context, selected, child){
            return Row(
              children: [
                _buildButtonView(
                    onTap: (){
                      widget.onFirstTabTap();
                      _selectedTabNotifier.value = 1;
                    },
                    title: widget.firstTabTitle,
                    selected: selected == 1
                ),
                Flexible(flex: 1, child: Container()),
                _buildButtonView(
                    onTap: (){
                      widget.onSecondTabTap();
                      _selectedTabNotifier.value = 2;
                    },
                    title: widget.secondTabTitle,
                    selected: selected == 2
                )
              ],
            );
          }
      ),
    );
  }

  _buildButtonView({Function? onTap,String? title,bool selected = false}){
    return Expanded(
        flex: 5,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: selected ? Border.all(color: AppColors.APPLE_GREEN,width: 1.5) : null,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: GestureDetector(
            onTap: ()=> onTap!=null ? onTap() : null,
            child: Container(
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: selected ? AppColors.Dark_spring_green : AppColors.Ash_grey
                ),
                child: Center(
                    child: CustomText(
                      title: title ?? '',
                      textColor: selected ? Colors.white : AppColors.Liver,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )
                )
            ),
          ),
        )
    );
  }
}
