import 'package:flutter/material.dart';

import '../../widgets/text_button.dart';
import '../ads/ads_page.dart';

class UserSettings extends StatelessWidget {
  const UserSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextBtn(
          onPress: () {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => AdsPage()));
          },
          text: 'Show Ads',
          color: Colors.black,
        ),
      ),
    );
  }
}
