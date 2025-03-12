import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import '../../../core/di/injection_container.dart' as di;
import '../../app_base/widgets/custom_app_bar.dart';
import '../view_models/navigation_drawer_mixin.dart';

class AboutUsScreen extends ConsumerWidget with NavigationDrawerMixin {
  static const routeName = '/about_us';

  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aboutUsState = ref.watch(di.aboutUsViewModelProvider);
    final aboutUsData = aboutUsState.data;

    return Scaffold(
      backgroundColor: AppColors.LIGHT_BACKGROUND,
      appBar: CustomAppBar(
        showNotificationsButton: true,
        showDrawer: true,
        hasbackButton: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          width: MediaQuery.of(context).size.width,
          child: aboutUsState.isLoading
              ? const Center(
                  child: CircularProgressIndicator()) // Show loading indicator
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      CustomText(
                        title: aboutUsData?['title'] ?? "About Us",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.APP_BLUE,
                      ),
                      const SizedBox(height: 25),
                      CustomText(
                        textAlign: TextAlign.center,
                        title: aboutUsData?['content'] ?? "About Us Content",
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        textColor: AppColors.APP_BLUE,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
