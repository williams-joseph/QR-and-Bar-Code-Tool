import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'scanner_screen.dart';
import 'generate_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

/// The main application container that handles navigation between the primary screens.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Keeps track of the currently selected tab in the bottom navigation bar.
  int _currentIndex = 0;

  // The list of screens available for navigation.
  final List<Widget> _screens = [
    const ScannerScreen(),
    const GenerateScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use IndexedStack to maintain the state of each screen while switching tabs.
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          // Update the selected index when a tab is tapped.
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
