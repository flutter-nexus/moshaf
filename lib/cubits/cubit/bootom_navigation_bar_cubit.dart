import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moshaf/imports/imports.dart';

part 'bootom_navigation_bar_state.dart';

class BootomNavigationBarCubit extends Cubit<BootomNavigationBarState> {
  BootomNavigationBarCubit() : super(BootomNavigationBarInitial());
   final List<Widget> pages = [
    HomeScreen(),
    QuranIndexPage(),
    PrayerTimeScreen(),
    SettingsScreen(),
  ];
}
