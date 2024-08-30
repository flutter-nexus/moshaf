import '../../../imports/imports.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBeige,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // لون الأيقونة
        ),
        backgroundColor: tealBlue,
        title: Text(
          'The Home Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              home_page_container(
                title: "The Holy Quran",
                subtitle: "The reading of the Holy Quran and its recitations",
                onTap: () => Get.to(QuranIndexPage()),
              ),
              home_page_container(
                title: "Prayer times",
                subtitle: "Prayer, fasting and iftar times",
                onTap: () => Get.to(PrayerTimeScreen()),
              ),
              home_page_container(
                title: "Teaching prayer",
                subtitle: "On the Sunnah of our Prophet",
                onTap: () => Get.to(() => TeachingPrayScreen(),
                    arguments: "تعليم الصلاة"),
              ),
              home_page_container(
                title: "Teaching ablution",
                subtitle: "On the Sunnah of our Prophet",
                onTap: () => Get.to(() => TeachingPrayScreen(),
                    arguments: "تعليم الوضوء"),
              ),
              home_page_container(
                title: "The noble hadith",
                subtitle: "The Hadith of the Prophet",
                onTap: () => Get.to(Hadith()),
              ),
              home_page_container(
                title: "Supplications page",
                subtitle: "Various supplications",
                onTap: () => Get.to(Supplications()),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomBottomNavigationBar(),
        )
      ]),
    );
  }
}
