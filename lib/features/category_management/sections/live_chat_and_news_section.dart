// ================== SECTION: Live Chat & News ==================
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/messages_management/screens/messages_list_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/reusable_container_widget.dart';

class LiveChatAndNewsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ActionButton(
                title: "live_chat".tr(),
                onTap: () {
                  openWhatsapp();
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

              // Add the "coming soon" label
              // PositionedDirectional(
              //   top: 0,
              //   start: 0,
              //   child: Container(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
              //     decoration: BoxDecoration(
              //         color: Colors.red.withValues(alpha: 0.7),
              //         borderRadius: context.locale.languageCode == "en"
              //             ? BorderRadius.only(topLeft: Radius.circular(20))
              //             : BorderRadius.only(topRight: Radius.circular(20)),
              //         boxShadow: [
              //           BoxShadow(
              //             color:
              //                 AppColors.APP_CARDS_BLUE.withValues(alpha: 0.3),
              //             spreadRadius: 0.5,
              //             blurRadius: 2,
              //             offset: const Offset(1, 2),
              //           ),
              //         ]),
              //     child: Text(
              //       "coming_soon".tr(),
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 12, // Smaller text size
              //         fontWeight: FontWeight.normal,
              //       ),
              //     ),
              //   ),
              // ),
            ],
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MessagesListScreen();
              }));
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

void openWhatsapp() async {
  // Replace with your WhatsApp number
  String phoneNumber = "+201148730069";

  // Replace with your WhatsApp message
  String message = "Hello, I need help!";

  // Open WhatsApp with the specified number and message
  String url =
      "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
