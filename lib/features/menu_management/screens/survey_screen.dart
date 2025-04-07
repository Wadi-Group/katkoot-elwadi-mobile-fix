import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';

class SurveyScreen extends StatefulWidget {
  static const routeName = '/survey';

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': "How would you rate the app you're using now?",
      'options': ['Very easy', 'Easy', 'Difficult'],
    },
    {
      'question': "How would you rate the app overall user experience?",
      'options': ['Excellent', 'Good', 'Poor'],
    },
    {
      'question': 'What features do you find most useful in the app?',
      'options': [
        "Performance data",
        "Feeding specifications",
        "Growth tracking"
      ],
    },
  ];

  int _currentQuestion = 0;
  int? _selectedOption;
  List<int> _answers = [];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late ConfettiController _confettiController;

  bool _showConfirmation = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _confettiController = ConfettiController(duration: Duration(seconds: 2));
    _controller.forward();
  }

  void _onOptionSelected(int index) {
    setState(() {
      _selectedOption = index;
    });
  }

  void _onContinue() async {
    if (_selectedOption == null) return;

    _answers.add(_selectedOption!);

    if (_currentQuestion == _questions.length - 1) {
      debugPrint('Answers: $_answers');
      setState(() {
        _showConfirmation = true;
      });
      _confettiController.play();
    } else {
      await _controller.reverse();
      setState(() {
        _currentQuestion++;
        _selectedOption = null;
      });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  Widget _buildOption(String label, String text, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => _onOptionSelected(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.APP_BLUE : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.APP_BLUE.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected ? Colors.white : Colors.grey.shade300,
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColors.APP_BLUE : Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[800],
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationOverlay(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.6),
          child: Center(
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOutBack,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          colors: [AppColors.APP_BLUE, Colors.purpleAccent],
                        ).createShader(rect);
                      },
                      child: Icon(
                        Icons.celebration_rounded,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'thank_you'.tr(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.APP_BLUE,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'survey_complete_message'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.APP_BLUE,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('done'.tr()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        /// Confetti
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            maxBlastForce: 25,
            minBlastForce: 10,
            numberOfParticles: 50,
            gravity: 0.3,
            colors: [
              Colors.blue,
              Colors.purple,
              Colors.pink,
              Colors.green,
              Colors.orange,
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestion];
    final totalQuestions = _questions.length;

    return Scaffold(
      backgroundColor: AppColors.LIGHT_BACKGROUND,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  /// Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'survey'.tr(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.APP_BLUE,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.close, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),

                  /// Progress
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(10),
                          minHeight: 10,
                          value: (_currentQuestion + 1) / totalQuestions,
                          color: AppColors.APP_BLUE,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${_currentQuestion + 1}/$totalQuestions',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),

                  /// Question + Options
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question['question'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.APP_BLUE,
                          ),
                        ),
                        SizedBox(height: 80),
                        ...List.generate(
                          question['options'].length,
                          (index) => _buildOption(
                            String.fromCharCode(65 + index),
                            question['options'][index],
                            index,
                            _selectedOption == index,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacer(),

                  /// Continue / Finish Button
                  ElevatedButton(
                    onPressed: _selectedOption == null ? null : _onContinue,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60),
                      backgroundColor: _selectedOption == null
                          ? Colors.grey
                          : AppColors.APP_BLUE,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _currentQuestion == totalQuestions - 1
                          ? 'finish'.tr().toUpperCase()
                          : 'continue'.tr().toUpperCase(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showConfirmation) _buildConfirmationOverlay(context),
        ],
      ),
    );
  }
}
