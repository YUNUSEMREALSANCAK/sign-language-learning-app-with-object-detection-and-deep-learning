import 'package:flutter/material.dart';

import '../../component.dart';
import '../../variables.dart';
import '../login_page/login_page.dart';
import 'information_about_variables.dart';

class OnboardingScreen extends StatelessWidget {
   OnboardingScreen({super.key});

  final PageController _pageController = PageController();

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          buildPage(
            color:CustomTheme.colorPage1,
            image: image3,
            title: titlePage1,
            subtitle: subtitlePage1,
            gradientColors: [CustomTheme.colorPage1,CustomTheme.colorPage2],
            iconbutton: IconButton(
              icon:nextpageicon,
              onPressed: () {
              },
            ),

          ),
          buildPage(
            color: CustomTheme.colorPage2,
            image: image2,
            title: titlePage2,
            subtitle: subtitlePage2,
            gradientColors: [CustomTheme.colorPage1,CustomTheme.colorPage2],
            iconbutton: IconButton(
              icon: nextpageicon,
              onPressed: () {
              },
            ),
          ),
          buildPage(
            color: CustomTheme.colorPage2,
            image: image5,
            title: titlePage3,
            subtitle: subtitlePage3,
            gradientColors: [CustomTheme.colorPage1,CustomTheme.colorPage2],
            iconbutton: IconButton(
              icon: login_page_start,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );

              },
            ),
          ),
        ],
      ),
    );

  }

  Widget buildPage({
    required List<Color> gradientColors,
    required Color color,
    required String image,
    required String title,
    required String subtitle,
    required IconButton iconbutton, // Zorunlu IconButton parametresi
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, // Gradient yukarıdan aşağıya
          end: Alignment.bottomCenter,
          colors: gradientColors, // Renk geçişleri
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, height: 250),
              const SizedBox(height: 32),
              Text(
                title,
                style: titleTextStyle(),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                style: subtitleTextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight, // İkonu sağ alt köşeye hizala
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 50, right: 16, bottom: 30), // İkonun kenarlardan uzaklığı
              child: iconbutton,
            ),
          ),
        ],
      ),
    );
  }
}