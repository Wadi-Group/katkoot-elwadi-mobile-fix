// ================== SECTION: Live Chat & News ==================
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';

import '../widgets/reusable_container_widget.dart';

class LiveChatAndNewsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ActionButton(
            title: "live_chat".tr(),
            onTap: () {
              // Navigator.of(context).pushNamed(LiveChatScreen.routeName);
            },
            image: "assets/images/live_chat.png",
            borderRadius: context.locale.languageCode == "en"
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: ActionButton(
            image: "assets/images/news.png",
            borderRadius: context.locale.languageCode == "en"
                ? const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
            title: "news".tr(),
            onTap: () {
              // Navigator.of(context).pushNamed(NewsScreen.routeName);
            },
          ),
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final BorderRadius borderRadius;
  final String image;

  const ActionButton({
    required this.title,
    required this.onTap,
    required this.image,
    Key? key,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: ReusableContainer(
        boxShadow: [
          BoxShadow(
            color: AppColors.APP_CARDS_BLUE.withValues(alpha: 0.3),
            spreadRadius: 0.5,
            blurRadius: .5,
            offset: const Offset(.5, .5),
          ),
        ],
        height: 60,
        borderRadius: borderRadius,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: title,
                textColor: AppColors.APP_BLUE,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(width: 10),
              Image.asset(
                image,
                width: 15,
                height: 15,
                color: AppColors.APP_BLUE,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
