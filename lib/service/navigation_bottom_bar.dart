import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:moshaf/imports/imports.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  _handleIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Get.off(_pages[index]);
  }

  final List<Widget> _pages = [
    HomeScreen(),
    QuranIndexPage(),
    PrayerTimeScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CrystalNavigationBar(
      duration: Duration(milliseconds: 300),
      currentIndex: _selectedIndex,
      indicatorColor: navyBlue,
      paddingR: EdgeInsets.all(2),
      unselectedItemColor: lightBeige,
      backgroundColor: tealBlue.withOpacity(0.7),
      outlineBorderColor: lightBlue,
      marginR: EdgeInsets.all(10),
      borderRadius: 30,
      onTap: _handleIndexChanged,
      items: [
        /// Home
        CrystalNavigationBarItem(
          icon: Icons.home_filled,
          unselectedIcon: Icons.home_filled,
          selectedColor: navyBlue,
        ),

        /// Favourite
        CrystalNavigationBarItem(
          icon: FlutterIslamicIcons.quran,
          unselectedIcon: FlutterIslamicIcons.quran,
          selectedColor: navyBlue,
        ),

        /// Add
        CrystalNavigationBarItem(
          icon: FlutterIslamicIcons.prayingPerson,
          unselectedIcon: FlutterIslamicIcons.prayingPerson,
          selectedColor: navyBlue,
        ),

        /// Search
        // CrystalNavigationBarItem(
        //     icon: IconlyBold.search,
        //     unselectedIcon: IconlyLight.search,
        //     selectedColor: Colors.white),

        /// Profile
        CrystalNavigationBarItem(
          icon: Icons.settings,
          unselectedIcon: Icons.settings,
          selectedColor: navyBlue,
        ),
      ],
    );
  }
}
