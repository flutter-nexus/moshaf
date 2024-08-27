import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:get/get.dart';
import 'package:moshaf/view/hadith/hadith.dart';
import '../view/home/home_page_helper/HomeScreen.dart';
import '../view/prayer_times/time_of_prayer.dart';
import '../view/quran/index_quuran.dart';
import '../view/teaching_ablution/teaching_ablution.dart';
import '../view/teaching_pray/teaching_pray.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.teal,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(FlutterIslamicIcons.mosque),
            onPressed: () {
              Get.offAll(() => HomeScreen());
            },
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(FlutterIslamicIcons.solidQuran2),
            onPressed: () {
              Get.offAll(() => QuranIndexPage());
            },
          ),
          label: "Qur'an",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              onPressed: () {
                Get.off(() => Hadith());
              },
              icon: Icon(
                FlutterIslamicIcons.solidMohammad,
                size: 30,
              )),
          label: 'Hadith',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(FlutterIslamicIcons.prayingPerson),
            onPressed: () {
              Get.off(() => PrayerTimeScreen());
            },
          ),
          label: 'Prayer times',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: const Icon(FlutterIslamicIcons.solidSajadah),
            onPressed: () {
              Get.off(() => TeachingPray());
            },
          ),
          label: 'Teaching Pray',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(FlutterIslamicIcons.solidWudhu),
            onPressed: () {
              Get.off(() => TeachingAblution());
            },
          ),
          label: 'Teaching Ablution',
        ),
      ],
      currentIndex: _selectedIndex, //New
      onTap: _onItemTapped,
      selectedItemColor: Colors.white,
    );
  }
}
