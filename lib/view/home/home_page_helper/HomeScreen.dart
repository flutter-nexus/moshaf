import '../../../imports/imports.dart';

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
          'The Home Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildGridItem(
                label: "Qur'an",
                icon: FlutterIslamicIcons.quran,
                onTap: () {
                  Get.to(() => QuranIndexPage());
                },
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // عدد الأعمدة
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    buildGridItem(
                        label: "Prayer Times",
                        icon: FlutterIslamicIcons.prayingPerson,
                        onTap: () {
                          Get.to(() => PrayerTimeScreen());
                        }),
                    buildGridItem(
                        label: "Teaching Prayer",
                        icon: FlutterIslamicIcons.sajadah,
                        onTap: () {
                          Get.to(() => TeachingPrayScreen(),
                              arguments: 'تعليم الصلاة');
                        }),
                    buildGridItem(
                        label: "Teaching Wudu",
                        icon: FlutterIslamicIcons.wudhu,
                        onTap: () {
                          Get.to(() => TeachingPrayScreen(),
                              arguments: "تعليم الوضوء");
                        }),
                    buildGridItem(
                        label: "Settings",
                        icon: Icons.settings,
                        onTap: () {
                          Get.to(() => SettingsScreen());
                        }),
                  ],
                ),
              ),
            ],
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
