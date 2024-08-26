import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moshaf/view/quran/index_quuran.dart';

import 'home_page_helper/home_page_container.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageList = [
    'assets/images/background.jpg',
    'assets/images/background.jpg',
    'assets/images/background.jpg',
    'assets/images/background.jpg',
    'assets/images/background.jpg',
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // لون الأيقونة
        ),
        backgroundColor: Colors.teal,
        title: Text(
          'The Home Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: screenHeight / 4, // التلت
              child: CarouselSlider(
                options: CarouselOptions(
                  height: screenHeight / 3, // التلت
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: imageList
                    .map((item) => Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(item,
                                fit: BoxFit.cover, width: screenWidth / 0.5),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    _currentIndex = entry.key;
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.04,
                    height: MediaQuery.of(context).size.width * 0.04,
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == entry.key
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
            home_page_container(
              title: "The Holy Quran",
              subtitle: "The reading of the Holy Quran",
              onTap: () => Get.to(QuranIndexPage()),
            ),
            home_page_container(
              title: "Prayer times",
              subtitle: "Prayer, fasting and iftar times",
              onTap: () => Get.to(QuranIndexPage()),
            ),
            home_page_container(
              title: "Teaching prayer",
              subtitle: "On the Sunnah of our Prophet",
              onTap: () => Get.to(QuranIndexPage()),
            ),
            home_page_container(
              title: "Teaching ablution",
              subtitle: "On the Sunnah of our Prophet",
              onTap: () => Get.to(QuranIndexPage()),
            ),
            home_page_container(
              title: "The noble hadith",
              subtitle: "The Hadith of the Prophet",
              onTap: () => Get.to(QuranIndexPage()),
            ),
            home_page_container(
              title: "Supplications page",
              subtitle: "Various supplications",
              onTap: () => Get.to(QuranIndexPage()),
            ),
          ],
        ),
      ),
    );
  }
}
