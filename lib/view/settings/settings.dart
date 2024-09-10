import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../../imports/imports.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

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
            decoration: BoxDecoration(color: tealBlue4),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildSectionHeader('Settings'),
                    _buildListTile(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      subtitle: _notificationsEnabled ? 'Enabled' : 'Disabled',
                      trailing: _buildSwitch(
                        value: _notificationsEnabled,
                        onToggle: (val) async {
                          final prefs = await SharedPreferences.getInstance();
                          if (val) {
                            Notifications().init();
                            print('notifications enabled');
                          } else {
                            Notifications().cancelAll();
                          }
                          await prefs.setBool('notifications', val);
                          setState(() => _notificationsEnabled = val);
                        },
                      ),
                    ),
                    _buildSectionHeader('Information'),
                    _buildListTile(
                      icon: Icons.info,
                      title: 'About Us',
                      subtitle: 'Learn more about our app',
                      onTap: () {
                        log("clicked");

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
                  ],
                ),
              ),
            ),
          ),
          CustomBottomNavigationBar()
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
        color: navyBlue,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: navyBlue,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.blueGrey,
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
      _notificationsEnabled = prefs.getBool('notifications') ?? false;
    });
  }
}
