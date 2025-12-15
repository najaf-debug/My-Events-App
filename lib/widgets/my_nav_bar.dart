import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_events_app/practice/screens/event_screen.dart';
import 'package:my_events_app/views/home_screen.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MainScreenState();
}

class _MainScreenState extends State<MyNavBar> {
  int _selectedIndex = 0;

  // 1. Define your screens
  final List<Widget> _screens = [HomeScreen(), EventScreen()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // 2. Displaying the current screen
        body: _screens[_selectedIndex],

        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent, // Background behind the bar
          color: Colors.blueAccent, // Color of the bar itself
          items: const <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.event, size: 30, color: Colors.white),
          ],
          onTap: (index) {
            // 4. Update screen when a tab is tapped
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
