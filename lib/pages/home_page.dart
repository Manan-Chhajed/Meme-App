import 'package:flutter/material.dart';
import 'package:meme_app/pages/home.dart';
import 'package:meme_app/pages/latest_memes.dart';
import 'package:meme_app/pages/profile.dart';

import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const UserHome(),
    const LatestMemes(),
    const UserSettings(),
    const UserProfile()
  ];

  final List<String> _titles = [
    "Home",
    "Latest Memes",
    "Settings",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    const double _size = 27;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            _titles[_selectedIndex],
          ),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex:
              _selectedIndex, // so when we tap, that one gets highlited
          onTap: _navigateBottomBar, // sets the _selectedIndex
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/home.png"),
                size: _size,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/trending-topic.png"),
                size: _size,
              ),
              label: 'Memes',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: _size,
              ),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: _size,
              ),
              label: 'Account',
            ),
          ]),
    );
  }
}
