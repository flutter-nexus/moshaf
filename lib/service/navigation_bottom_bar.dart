import 'dart:convert';

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:moshaf/imports/imports.dart';

import '../view/quran/quran_sura_page.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
 var widgejsonData;

  loadJsonAsset() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/surahs.json');
    var data = jsonDecode(jsonString);
    setState(() {
      widgejsonData = data;
    });
  }

  @override
  void initState() {
    loadJsonAsset();

    // TODO: implement initState
    super.initState();
  } 
  Widget build(BuildContext context) {
    final controller = Get.put(MuslimAppController());

    return Obx(() {
      return CrystalNavigationBar(
        duration: Duration(milliseconds: 300),
        currentIndex: controller.selectedIndex.value,
        indicatorColor: navyBlue,
        paddingR: EdgeInsets.all(2),
        unselectedItemColor: lightBeige,
        backgroundColor: tealBlue.withOpacity(0.7),
        outlineBorderColor: lightBlue,
        marginR: EdgeInsets.all(10),
        borderRadius: 30,
        onTap: (index) {
          controller.setIndex(index);
          if (index == 0) {
            Get.offAll(HomeScreen());
          } else if (index == 1) {
            Get.to(QuranPage(suraJsonData:widgejsonData ,), arguments: "القرآن الكريم");
          } else if (index == 2) {
            Get.to(PrayerTimeScreen());
          } else {
            Get.to(SettingsScreen());
          }
        },
        items: [
          CrystalNavigationBarItem(
            icon: Icons.home_filled,
            unselectedIcon: Icons.home_filled,
            selectedColor: navyBlue,
          ),
          CrystalNavigationBarItem(
            icon: FlutterIslamicIcons.quran,
            unselectedIcon: FlutterIslamicIcons.quran,
            selectedColor: navyBlue,
          ),
          CrystalNavigationBarItem(
            icon: FlutterIslamicIcons.prayingPerson,
            unselectedIcon: FlutterIslamicIcons.prayingPerson,
            selectedColor: navyBlue,
          ),
          CrystalNavigationBarItem(
            icon: Icons.settings,
            unselectedIcon: Icons.settings,
            selectedColor: navyBlue,
          ),
        ],
      );
    });
  }
}
