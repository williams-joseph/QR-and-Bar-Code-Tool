import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'scanner_screen.dart';
import 'generate_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ScannerScreen(),
    const GenerateScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.expand),
              activeIcon: Icon(FontAwesomeIcons.expand, size: 28),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.plus),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.clockRotateLeft),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.gear),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
