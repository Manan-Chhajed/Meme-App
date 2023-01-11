import 'package:flutter/material.dart';
import 'package:meme_app/pages/meme%20creator/home.dart';
import 'package:meme_app/pages/latest_memes.dart';
import 'package:meme_app/pages/profile/profile.dart';

import '../consts/colors.dart';
import 'settings/settings.dart';

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
    const double size = 27;
    return Scaffold(
      // backgroundColor: Color.fromRGBO(162, 165, 165, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(53, 62, 88, 1),
        // backgroundColor: Color.fromARGB(255, 208, 208, 63),
        title: Center(
          child: Text(_titles[_selectedIndex], style: TextStyle()),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromRGBO(255, 120, 44, 1),
        backgroundColor: Colors.white,
        elevation: 0.0,
        currentIndex: _selectedIndex, // so when we tap, that one gets highlited
        onTap: _navigateBottomBar, // sets the _selectedIndex
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/home.png"),
              size: size,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/trending-topic.png"),
              size: size,
            ),
            label: 'Memes',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: size,
            ),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: size,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
