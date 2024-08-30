import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return CrystalNavigationBar(
      duration: Duration(milliseconds: 300),
      currentIndex: _selectedIndex,
      indicatorColor: Colors.white,
      paddingR: EdgeInsets.all(2),
      unselectedItemColor: Colors.white70,
      backgroundColor: Colors.grey.withOpacity(0.6),
      outlineBorderColor: Colors.white.withOpacity(0.5),
      marginR: EdgeInsets.all(10),
      borderRadius: 500,
      onTap: _handleIndexChanged,
      items: [
        /// Home
        CrystalNavigationBarItem(
          icon: Icons.home_filled,
          unselectedIcon: Icons.home_filled,
          selectedColor: Colors.teal,
        ),

        /// Favourite
        CrystalNavigationBarItem(
          icon: FlutterIslamicIcons.quran,
          unselectedIcon: FlutterIslamicIcons.quran,
          selectedColor: Colors.teal,
        ),

        /// Add
        CrystalNavigationBarItem(
          icon: FlutterIslamicIcons.prayingPerson,
          unselectedIcon: FlutterIslamicIcons.prayingPerson,
          selectedColor: Colors.teal,
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
          selectedColor: Colors.teal,
        ),
      ],
    );
  }
}
