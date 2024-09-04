import 'package:moshaf/athan/athan_screen.dart';

import '../../../imports/imports.dart';
import '../../azkar/Azkar_Selection.dart';
import '../../tasbih/tasbih_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // لون الأيقونة
        ),
        backgroundColor: tealBlue,
        title: Text(
          'الصفحة الرئيسية',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildGridItem(
                  label: "القرآن الكريم",
                  icon: FlutterIslamicIcons.quran,
                  onTap: () {
                    Get.to(() => QuranIndexPage(), arguments: "القرآن الكريم");
                  },
                  width: double.infinity,
                ),
                buildGridItem(
                  label: "تفسير القرآن الكريم",
                  icon: FlutterIslamicIcons.quran2,
                  onTap: () {
                    Get.to(() => QuranIndexPage(),
                        arguments: "تفسير القرآن الكريم");
                  },
                  width: double.infinity,
                ),
                Row(
                  children: [
                    buildGridItem(
                      label: "مواقيت الصلاة",
                      icon: FlutterIslamicIcons.prayingPerson,
                      onTap: () {
                        Get.to(() => PrayerTimeScreen());
                      },
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    buildGridItem(
                      label: "تعليم الصلاة",
                      icon: FlutterIslamicIcons.sajadah,
                      onTap: () {
                        Get.to(() => TeachingPrayScreen(),
                            arguments: 'تعليم الصلاة');
                      },
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ],
                ),
                Row(
                  children: [
                    buildGridItem(
                      label: "تعليم الوضوء",
                      icon: FlutterIslamicIcons.wudhu,
                      onTap: () {
                        Get.to(() => TeachingPrayScreen(),
                            arguments: "تعليم الوضوء");
                      },
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    buildGridItem(
                      label: "أذكار",
                      icon: FlutterIslamicIcons.prayer,
                      onTap: () {
                        Get.to(() => Supplications());
                      },
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildGridItem(
                      label: "الاعدادات",
                      icon: Icons.settings,
                      onTap: () {
                        Get.to(() => AthanWidget(
                              prayerName: "Fajr",
                              prayerTime: "5:30 AM",
                            ));
                      },
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    buildGridItem(
                      label: "تسبيح",
                      icon: FlutterIslamicIcons.tasbihHand,
                      onTap: () {
                        Get.to(() => TasbeehScreen());
                      },
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.085),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomBottomNavigationBar(),
        ),
      ]),
    );
  }
}
