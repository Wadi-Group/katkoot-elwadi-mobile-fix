import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text_button.dart';

import '../../menu_management/screens/change_language_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/onboarding_1.png",
      "title": "Welcome to Katkoot Elwadi",
      "subtitle":
          "you are joining the family of users for 'Katkoot AlWadi' application, the first in Egypt to manage all poultry business with its unique tools to become your daily guide"
    },
    {
      "image": "assets/images/onboarding_2.png",
      "title": "Application Tools",
      "subtitle":
          "Now you can calculate the “Feed Conversion Ratio” and the “European Production Efficiency Factor” in a very easy way through CB tools and many more other professional tools"
    },
    {
      "image": "assets/images/onboarding_3.png",
      "title": "Videos",
      "subtitle":
          "Short professional video clips that help you to explain specialized technical topics by Wadi experts"
    },
    {
      "image": "assets/images/onboarding_4.png",
      "title": "Guides and Topics",
      "subtitle":
          "You can now browse your technical report for broilers through a smart tool that saves you time and effort to get an instant result"
    },
    {
      "image": "assets/images/onboarding_5.png",
      "title": "Technical Reports Generator",
      "subtitle":
          "The Guides section for Broilers, Broiler Parents, and commercial layers hens is characterized by having all the performance targets, flock management, breeding guide, and others that you need"
    },
    {
      "image": "assets/images/onboarding_6.png",
      "title": "News",
      "subtitle":
          "You will receive daily the most important local and international poultry industry news, in addition to the daily price of “Katkoot al Wadi”"
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        // go to language selection screen
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return ChangeLanguageScreen();
                        }));
                      },
                      child: CustomText(
                        title: "Skip",
                        textColor: AppColors.APP_BLUE,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                CustomText(
                  title: "Welcome to",
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.APP_BLUE,
                ),
                Image.asset(
                  "assets/images/black_logo.png",
                  height: 120,
                  width: 120,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 50),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _onboardingData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(_onboardingData[index]["image"]!,
                              height: 200),
                          SizedBox(height: 50),
                          CustomText(
                            title: _onboardingData[index]["title"]!,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            textColor: AppColors.APP_BLUE,
                          ),
                          SizedBox(height: 30),
                          CustomText(
                            title: _onboardingData[index]["subtitle"]!,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            textColor: AppColors.APP_BLUE,
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _currentPage == _onboardingData.length - 1
                    ? Center(
                        child: TextButton(
                          onPressed: () {
                            // go to language selection screen
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return ChangeLanguageScreen();
                            }));
                          },
                          child: CustomText(
                            title: "Get Started",
                            fontSize: 18,
                            italic: true,
                            fontWeight: FontWeight.w700,
                            textColor: AppColors.APP_BLUE,
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: CustomText(
                          title: "Next",
                          textColor: AppColors.APP_BLUE,
                          fontSize: 18,
                          italic: true,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 10,
                      width: _currentPage == index ? 10 : 10,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.APP_BLUE),
                        color: _currentPage == index
                            ? AppColors.APP_BLUE
                            : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
