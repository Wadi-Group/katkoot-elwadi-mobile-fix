// ================== SECTION: Auto-Scrolling Infinite  ==================
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/messages_management/models/message.dart';

import '../../app_base/widgets/custom_text.dart';
import '../widgets/reusable_container_widget.dart';

class AutoScrollingTextSection extends StatefulWidget {
  final List<Message> rotatingTexts;
  const AutoScrollingTextSection({
    Key? key,
    required this.rotatingTexts,
  }) : super(key: key);

  @override
  _AutoScrollingTextSectionState createState() =>
      _AutoScrollingTextSectionState();
}

class _AutoScrollingTextSectionState extends State<AutoScrollingTextSection> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  List<Message> get rotatingTexts => widget.rotatingTexts;

  @override
  void initState() {
    super.initState();
    _startScrolling();
  }

  void _startScrolling() {
    _timer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.offset + 1);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReusableContainer(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final message = rotatingTexts[index % rotatingTexts.length];
          return Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CustomText(
                  title: message.content ?? '',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  maxLines: 1,
                  lineSpacing: 1.1,
                  textColor: AppColors.APP_BLUE,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              // Add a vertical divider between texts
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppColors.Card_Color,
                ),
                height: 20,
                width: 2,
              ),
            ],
          );
        },
      ),
    );
  }
}
