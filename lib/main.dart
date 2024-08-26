import 'package:flutter/material.dart';
import 'package:moshaf/view/home/HomeScreen.dart';
import 'package:moshaf/view/auth/login_screen.dart';
import 'package:moshaf/view/auth/reset_password_screen.dart';
import 'package:moshaf/view/auth/signup_screen.dart';
import 'package:moshaf/view/auth/verification%20_code.dart';
import 'package:moshaf/view/quran/index_quuran.dart';
import 'package:moshaf/view/prayer_times/time_of_prayer.dart';
import 'package:moshaf/view/settings/settings.dart';
import 'package:get/get.dart';

import 'view/hadith/hadith.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> titles = [
    'Home Screen',
    'Login Screen',
    'Signup Screen',
    'Reset Password Screen',
    'Verification Code Screen',
    'Settings Screen',
    'Time of Prayer Screen',
    'Quran Index Screen',
    'Hadith Screen',
  ];
  final List<Widget> pages = [
    HomeScreen(),
    LoginScreen(),
    SignUpScreen(),
    ResetPasswordScreen(),
    VerificationCodeInput(
      controller: TextEditingController(),
      onCompleted: (value) {
        print(value);
      },
    ),
    SettingsScreen(),
    PrayerTimeScreen(),
    QuranIndexPage(),
    Hadith(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('page  List'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Center(child: Text(titles[index])),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return pages[index];
                  }),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
