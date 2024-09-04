import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();
  static SharedPreferences? _preferences;

  factory AppPreferences() {
    return _instance;
  }

  AppPreferences._internal();

  // Initialize SharedPreferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save a string value
  Future<void> saveString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  // Get a string value
  String? getString(String key) {
    return _preferences?.getString(key);
  }

  // Save an integer value
  Future<void> saveInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  // Get an integer value
  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  // Save a boolean value
  Future<void> saveBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  // Get a boolean value
  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  // Remove a specific value
  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  // Clear all saved preferences
  Future<void> clear() async {
    await _preferences?.clear();
  }
}
