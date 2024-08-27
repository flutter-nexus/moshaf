import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:get/get.dart';
import 'package:moshaf/service/navigation_bottom_bar.dart';
import 'package:moshaf/view/prayer_times/time_of_prayer.dart';
import 'package:moshaf/view/quran/index_quuran.dart';
import 'package:moshaf/view/settings/settings.dart';
import 'package:moshaf/view/teaching_pray/teaching_pray.dart';

import '../home/home_page_helper/HomeScreen.dart';
import '../teaching_ablution/teaching_ablution.dart';

class Hadith extends StatefulWidget {
  const Hadith({super.key});

  @override
  _HadithState createState() => _HadithState();
}

class _HadithState extends State<Hadith> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hadith"),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: Center(
          child: Text("Hadith"),
        ));
  }
}
