import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/utils/notification_click_handler.dart';
import 'package:katkoot_elwady/features/app_base/screens/main_bottom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/photo_hero.dart';
import 'package:katkoot_elwady/features/menu_management/screens/change_language_screen.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;

class MessageContentScreen extends StatefulWidget {
  static const routeName = "./message_content";
  final Message message;

  MessageContentScreen({required this.message});

  @override
  State<MessageContentScreen> createState() => _MessageContentScreenState();
}

class _MessageContentScreenState extends State<MessageContentScreen>
    with BaseViewModel {
  @override
  void initState() {
    readMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(
          hasbackButton: true,
          onBackClick: () async {
            if (await onWillPop()) {
              Navigator.pop(context);
            }
          },
        ),
        body: SafeArea(
          child: Stack(
            children: [
              _buildBackgroundImage(),
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMessageHeader(),
                    const SizedBox(height: 20),
                    _buildAttachmentSection(),
                    const SizedBox(height: 20),
                    _buildMessageContent(),
                    const SizedBox(height: 20),
                    _buildImageAttachment(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Background Image
  Widget _buildBackgroundImage() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.2,
          horizontal: MediaQuery.of(context).size.width * 0.18,
        ),
        child: Image.asset("assets/images/bg_image.png"),
      ),
    );
  }

  /// Message Title & Date
  Widget _buildMessageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: widget.message.title ?? '',
          textColor: AppColors.Dark_spring_green,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 10),
        CustomText(
          title: widget.message.schedule ?? '',
          textColor: AppColors.Liver,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  /// Attachment Section
  Widget _buildAttachmentSection() {
    if (widget.message.attachmentType?.isEmpty ?? true)
      return SizedBox.shrink();

    return GestureDetector(
      onTap: () => NotificationClickHandler.handleNotificationRedirection(
          widget.message, context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.Liver, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            _buildAttachmentIcon(),
            const SizedBox(width: 10),
            Expanded(
              child: CustomText(
                title: widget.message.attachmentTitle ?? '',
                fontSize: 14,
                textColor: AppColors.Liver,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Attachment Icon Based on Type
  Widget _buildAttachmentIcon() {
    String iconPath;
    switch (widget.message.attachmentType) {
      case "PDF":
      case "Guide":
        iconPath = "assets/images/group_3147.png";
        break;
      case "Video":
        iconPath = "assets/images/video.png";
        break;
      case "External URL":
        iconPath = "assets/images/link.png";
        break;
      default:
        return SizedBox.shrink();
    }

    return Image.asset(
      iconPath,
      fit: BoxFit.contain,
      height: 30,
    );
  }

  /// Message Content
  Widget _buildMessageContent() {
    return CustomText(
      title: widget.message.content ?? '',
      textColor: AppColors.Liver,
      fontSize: 17,
      fontWeight: FontWeight.w500,
    );
  }

  /// Image Attachment (if applicable)
  Widget _buildImageAttachment() {
    if (widget.message.attachmentType != "Image") return SizedBox.shrink();

    return GestureDetector(
      onTap: () => NotificationClickHandler.handleNotificationRedirection(
          widget.message, context),
      child: PhotoHero(message: widget.message),
    );
  }

  /// Mark Message as Read
  Future<void> readMessage() async {
    if (widget.message.isSeen == false) {
      await Future.delayed(Duration.zero, () {
        ProviderScope.containerOf(context, listen: false)
            .read(di.messagesViewModelProvider.notifier)
            .readMessage(widget.message.id!);
      });
    }
  }

  /// Handle Back Navigation
  Future<bool> onWillPop() async {
    if (di.appRedirectedFromNotificationNotifier.value) {
      final isOnboardingComplete =
          await ProviderScope.containerOf(context, listen: false)
              .read(di.changeLanguageViewModelProvider.notifier)
              .isOnBoardingComplete();

      navigateToScreen(
        isOnboardingComplete
            ? MainBottomAppBar.routeName
            : ChangeLanguageScreen.routeName,
        removeTop: true,
      );

      di.appRedirectedFromNotificationNotifier.value = false;
      return false;
    }
    return true;
  }
}
