import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../component.dart';
import '../variables.dart';

// Profil sayfası
class ProfilePage extends StatelessWidget {
  final String email;

  const ProfilePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.colorPage1,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [CustomTheme.colorPage1, CustomTheme.colorPage2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: CustomTheme.colorPage2,
                child: const Icon(
                  FontAwesomeIcons.user,
                  size: 50,
                  color: CustomTheme.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                email,
                style: titleTextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
