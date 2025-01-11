import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../variables.dart';
import 'Notifications.dart';
import 'camera/camera_page.dart';
import 'cardscreen/cardscreen.dart';
import 'quizPage/quiz_page.dart';
import 'quizPage/quiz_viewmodel.dart';

class Navigation extends StatefulWidget {
  final QuizViewModel quizViewModel;

  const Navigation({
    super.key,
    required this.quizViewModel,
  });

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      const HomePage(),
      QuizPage(
        key: PageStorageKey('QuizPage'),
        quizViewModel: widget.quizViewModel,
      ),
      NotificationsPage(quizViewModel: widget.quizViewModel),
      ImagePickerDemo(),
    ];
  }

  // Seçili sayfa değiştiğinde tetiklenecek fonksiyon
  void _onItemTapped(int index) {
    if (index >= 0 && index < _pages.length) {
      // Güvenlik kontrolü
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.colorPage1,
        title: const Text('İşaret Dili Öğreniyorum'),
      ),
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CustomTheme.colorPage1,
              CustomTheme.colorPage3,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.magnifyingGlass),
            label: 'Arama',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bell),
            label: 'İstatistik',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.camera),
            label: 'Kamera',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: CustomTheme.colorPage3,
        unselectedItemColor: CustomTheme.colorPage1,
        backgroundColor: Colors.transparent,
        elevation: 0.5,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
