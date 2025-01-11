import 'package:flutter/material.dart';
import 'package:isaretdilitercumaniprojesi/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Screens/navigation.dart';
import 'information_about_app_screen/information_about_app_screen.dart';
import 'quizPage/quiz_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final QuizViewModel _quizViewModel = QuizViewModel();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _quizViewModel.loadStatistics();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Navigation(
            quizViewModel: _quizViewModel,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: CustomTheme.primaryGradient,
        ),
        child: Center(
          child: Image.asset(
            Images.images1,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
