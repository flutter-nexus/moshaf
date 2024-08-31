import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../imports/imports.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _recitationEnabled = true;
  double _playbackSpeed = 1.0;
  String _selectedLanguage = 'English';
  ThemeMode _selectedTheme = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    getSettingsData();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: tealBlue,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: screenHeight,
            decoration:  BoxDecoration(color: tealBlue),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildSectionHeader('General Settings'),
                    _buildListTile(
                      icon: Icons.language,
                      title: 'Language',
                      subtitle: _selectedLanguage,
                      trailing: _buildDropdown(
                        value: _selectedLanguage,
                        onChanged: (String? newValue) async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('language', newValue!);
                          setState(() => _selectedLanguage = newValue);
                        },
                        items: ['English', 'Arabic', 'French', 'Spanish'],
                      ),
                    ),
                    _buildListTile(
                      icon: Icons.brightness_medium,
                      title: 'Theme',
                      subtitle: _selectedTheme == ThemeMode.light ? 'Light' : 'Dark',
                      trailing: _buildDropdown(
                        value: _selectedTheme,
                        onChanged: (ThemeMode? newValue) async {
                          final prefs = await SharedPreferences.getInstance();
                          final themeModeString = newValue == ThemeMode.light ? 'light' : 'dark';
                          await prefs.setString('themeMode', themeModeString);
                          setState(() => _selectedTheme = newValue!);
                        },
                        items: [ThemeMode.light, ThemeMode.dark],
                        itemBuilder: (value) => Text(value == ThemeMode.light ? 'Light' : 'Dark'),
                      ),
                    ),
                    _buildSectionHeader('Audio Settings'),
                    _buildListTile(
                      icon: Icons.volume_up,
                      title: 'Recitation',
                      subtitle: _recitationEnabled ? 'Enabled' : 'Disabled',
                      trailing: _buildSwitch(
                        value: _recitationEnabled,
                        onToggle: (val) async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('recitation', val);
                          setState(() => _recitationEnabled = val);
                        },
                      ),
                    ),
                    _buildListTile(
                      icon: Icons.speed,
                      title: 'Playback Speed',
                      subtitle: '${_playbackSpeed}x',
                      trailing: _buildSlider(
                        value: _playbackSpeed,
                        onChanged: (value) async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setDouble('playbackSpeed', value);
                          setState(() => _playbackSpeed = value);
                        },
                        min: 0.5,
                        max: 2.0,
                        divisions: 3,
                      ),
                    ),
                    _buildSectionHeader('Advanced Settings'),
                    _buildListTile(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      subtitle: _notificationsEnabled ? 'Enabled' : 'Disabled',
                      trailing: _buildSwitch(
                        value: _notificationsEnabled,
                        onToggle: (val) async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('notifications', val);
                          setState(() => _notificationsEnabled = val);
                        },
                      ),
                    ),
                    _buildListTile(
                      icon: Icons.cloud_upload,
                      title: 'Backup & Restore',
                      subtitle: 'Last backup: 2 days ago',
                      onTap: () {
                        // Handle backup & restore
                      },
                    ),
                    _buildSectionHeader('Information'),
                    _buildListTile(
                      icon: Icons.info,
                      title: 'About Us',
                      subtitle: 'Learn more about our app',
                      onTap: () {
                        log("clicked");
                        log("${getPageData(3).toString()}");
                        log("end");
                        // Navigate to About Us page
                      },
                    ),
                    _buildListTile(
                      icon: Icons.privacy_tip,
                      title: 'Privacy Policy',
                      subtitle: 'View our privacy policy',
                      onTap: () {
                        // Navigate to Privacy Policy page
                      },
                    ),
                    _buildListTile(
                      icon: Icons.help,
                      title: 'Help & Support',
                      subtitle: 'Get help and support',
                      onTap: () {
                        // Navigate to Help & Support page
                      },
                    ),
                    _buildListTile(
                      icon: Icons.help,
                      title: '',
                      subtitle: '',
                      onTap: () {
                        // Navigate to Help & Support page
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const CustomBottomNavigationBar()
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required Function(T?) onChanged,
    required List<T> items,
    Widget Function(T)? itemBuilder,
  }) {
    return Container(
      width: 100,
      child: DropdownButton<T>(
        value: value,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: itemBuilder != null
                ? itemBuilder(value)
                : Text(value.toString()),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSwitch({
    required bool value,
    required Function(bool) onToggle,
  }) {
    return SizedBox(
      width: 50,
      child: FlutterSwitch(
        value: value,
        onToggle: onToggle,
      ),
    );
  }

  Widget _buildSlider({
    required double value,
    required Function(double) onChanged,
    required double min,
    required double max,
    required int divisions,
  }) {
    return SizedBox(
      width: 150,
      child: Slider(
        activeColor: Colors.blueAccent,
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        label: value.toString(),
        onChanged: onChanged,
      ),
    );
  }

  Future<void> getSettingsData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _selectedLanguage = prefs.getString('language') ?? 'English';
      _playbackSpeed = prefs.getDouble('playbackSpeed') ?? 1.0;
      _recitationEnabled = prefs.getBool('recitation') ?? false;
      _notificationsEnabled = prefs.getBool('notifications') ?? false;
      final themeModeString = prefs.getString('themeMode');
      _selectedTheme = themeModeString == 'dark' ? ThemeMode.dark : ThemeMode.light;
    });
  }
}