import 'package:flutter/material.dart';

import 'profile_menu.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/house.png",
            press: () => {
              print("My Account"),
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/house.png",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/house.png",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/house.png",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/house.png",
            press: () {},
          ),
        ],
      ),
    );
  }
}
