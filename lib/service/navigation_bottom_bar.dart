import '../imports/imports.dart';

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
            icon: const Icon(FlutterIslamicIcons.prayingPerson),
            onPressed: () {
              Get.to(() => PrayerTimeScreen());
            },
          ),
          label: 'Prayer times',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
              onPressed: () {
                Get.to(() => SettingsScreen());
              },
              icon: Icon(
                Icons.settings_outlined,
                size: 30,
              )),
          label: 'Settings',
        ),
      ],
      currentIndex: _selectedIndex, //New
      onTap: _onItemTapped,
      selectedItemColor: Colors.white,
    );
  }
}
