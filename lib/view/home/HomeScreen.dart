import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moshaf/view/hadith/hadith.dart';
import 'package:moshaf/view/prayer_times/time_of_prayer.dart';
import 'package:moshaf/view/quran/index_quuran.dart';
import 'package:moshaf/view/supplications/supplications.dart';
import 'package:moshaf/view/teaching_ablution/teaching_ablution.dart';
import 'package:moshaf/view/teaching_pray/teaching_pray.dart';
import 'home_page_helper/home_page_container.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageList = [
    'assets/slider_images/quran1.jpg',
    'assets/slider_images/pray_times2.jpg',
    'assets/slider_images/teaching_pray2.jpg',
    'assets/slider_images/ablution2.jpg',
    'assets/slider_images/hadith2.jpg',
    'assets/slider_images/doaa2.jpg',
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
              width: screenWidth,
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
                                fit: BoxFit.fitWidth,
                                width: MediaQuery.of(context).size.width),
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
              titleColor: Colors.white,
              image: "quran2",
              title: "The Holy Quran",
              subtitle: "The reading of the Holy Quran and its recitations",
              onTap: () => Get.to(QuranIndexPage()),
            ),
            home_page_container(
              titleColor: Colors.white,
              image: "pray_times1",
              title: "Prayer times",
              subtitle: "Prayer, fasting and iftar times",
              onTap: () => Get.to(PrayerTimeScreen()),
            ),
            home_page_container(
              titleColor: Colors.white,
              image: "teaching_pray1",
              title: "Teaching prayer",
              subtitle: "On the Sunnah of our Prophet",
              onTap: () => Get.to(TeachingPray()),
            ),
            home_page_container(
              titleColor: Colors.white,
              image: "ablution1",
              title: "Teaching ablution",
              subtitle: "On the Sunnah of our Prophet",
              onTap: () => Get.to(TeachingAblution()),
            ),
            home_page_container(
              titleColor: Colors.white,
              image: "hadith1",
              title: "The noble hadith",
              subtitle: "The Hadith of the Prophet",
              onTap: () => Get.to(Hadith()),
            ),
            home_page_container(
              titleColor: Colors.white,
              image: "doaa1",
              title: "Supplications page",
              subtitle: "Various supplications",
              onTap: () => Get.to(Supplications()),
            ),
          ],
        ),
      ),
    );
  }
}
