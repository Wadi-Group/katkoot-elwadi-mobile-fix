import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../app_base/widgets/custom_text.dart';
import '../../app_base/widgets/tool_types.dart';
import '../../tools_management/models/tool.dart';
import '../models/category.dart';
import '../widgets/reusable_container_widget.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;

class ReportGeneratorSection extends ConsumerWidget {
  final List<Category>? categories;
  const ReportGeneratorSection({
    Key? key,
    this.categories,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toolsViewModel = ref.read(di.toolsViewModelProvider.notifier);
    final toolsState = ref.watch(di.toolsViewModelProvider);

    return Column(
      children: [
        ReportGenerator(
          disableContainer: true,
          title: "cb_report_generator".tr(),
          subtitle: "str_add_new_cycle".tr(),
          onTap: () async {
            await toolsViewModel
                .getTools(2); // Replace 1 with correct categoryId

            Tool? cbTool = toolsState.data?.firstWhere(
              (tool) => tool.type == ToolTypes.CB_RG,
              orElse: () => Tool(),
            );

            if (cbTool != null) {
              toolsViewModel.openToolDetails(
                  context, cbTool, categories![1], 2);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Tool not found")),
              );
            }
          },
          icon: Image.asset(
            'assets/images/add_cycle.png',
            color: AppColors.APP_BLUE,
            width: 20,
            height: 20,
          ),
        ),
        SizedBox(height: 20),
        ReportGenerator(
          title: "ps_report_generator".tr(),
          subtitle: "str_add_new_cycle".tr(),
          onTap: () async {
            await toolsViewModel.getTools(1); // Fetch tools for category 1

            // Delay execution slightly to allow state update
            await Future.delayed(Duration(milliseconds: 300));

            // Retrieve the updated state
            final toolsState = ref.read(di.toolsViewModelProvider);

            // Find the tool of type PS_RG
            Tool? psTool = toolsState.data?.firstWhere(
              (tool) => tool.type == ToolTypes.PS_RG,
              orElse: () => Tool(id: -1, title: "Invalid Tool"),
            );

            if (psTool != null) {
              toolsViewModel.openToolDetails(
                context,
                psTool,
                categories![0],
                1,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Tool not found")),
              );
            }
          },
          icon: Image.asset(
            'assets/images/add_cycle.png',
            color: AppColors.APP_BLUE,
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }
}

class ReportGenerator extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Widget? icon;
  final bool? disableContainer;

  const ReportGenerator({
    required this.title,
    required this.onTap,
    this.subtitle,
    this.icon,
    this.disableContainer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ReusableContainer(
        disableContainer: disableContainer,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 15),
        borderRadius: BorderRadius.circular(12), // Optional border radius
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Space between text & icon
          children: [
            Image.asset(
              "assets/images/elite_logo.png",
              width: 30,
              color: AppColors.Elite_Logo_Color,
              height: 30,
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomText(
                title: title,
                textColor: AppColors.APP_BLUE,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                lineSpacing: 1,
              ),
            ),
            SizedBox(width: 10),
            CustomText(
              title: subtitle ?? "",
              textColor: AppColors.APP_BLUE,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(width: 10),
            icon ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
