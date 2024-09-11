import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:moshaf/service/shared_prefrece.dart';
import '../../imports/imports.dart';

class PrayerTimeScreen extends StatefulWidget {
  @override
  _PrayerTimeScreenState createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  Position? _currentPosition;
  Map<String, String>? _prayerTimes;
  bool _loading = true;
  String? _errorMessage;
  String datehijri = "", datenepali = "";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadPrayerTimes(); // استرجاع مواقيت الصلاة عند فتح التطبيق
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await _determinePosition();
      setState(() => _loading = true);
      await _fetchPrayerTimes(_currentPosition!);
    } catch (e) {
      _handleError(e);
    }
  }

  Future<Position> _determinePosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('Location services are disabled.');
    }
    
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    
    if (permission == LocationPermission.deniedForever || 
        permission != LocationPermission.whileInUse && 
        permission != LocationPermission.always) {
      throw Exception('Location permissions are denied.');
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Future<void> _fetchPrayerTimes(Position position) async {
    try {
      final response = await Dio().get('https://api.aladhan.com/v1/timings', 
        queryParameters: {'latitude': position.latitude, 'longitude': position.longitude, 'method': 5});

      final data = response.data['data'];
      setState(() {
        datehijri = data['date']['readable'];
        datenepali = "${data['date']['hijri']['day']} ${data['date']['hijri']['month']['en']} ${data['date']['hijri']['year']}";
        _prayerTimes = {
          'الفجر': _formatTime(data['timings']['Fajr']),
          'الظهر': _formatTime(data['timings']['Dhuhr']),
          'العصر': _formatTime(data['timings']['Asr']),
          'المغرب': _formatTime(data['timings']['Maghrib']),
          'العشاء': _formatTime(data['timings']['Isha']),
        };
        _loading = false;
      });
      _savePrayerTimes(); // حفظ مواقيت الصلاة بعد تحميلها
    } catch (e) {
      _handleError(e);
    }
  }

  // حفظ مواقيت الصلاة في SharedPreferences
  void _savePrayerTimes() async {
    await AppPreferences().init(); // تأكد من تهيئة AppPreferences
    
    for (var entry in _prayerTimes!.entries) {
      await AppPreferences().saveString(entry.key, entry.value); // حفظ كل وقت صلاة
    }

    await AppPreferences().saveString('datehijri', datehijri);
    await AppPreferences().saveString('datenepali', datenepali);
    
  }

  // استرجاع مواقيت الصلاة من SharedPreferences
  Future<void> _loadPrayerTimes() async {
    await AppPreferences().init();

    setState(() {
      _prayerTimes = {
        'الفجر': AppPreferences().getString('الفجر') ?? '',
        'الظهر': AppPreferences().getString('الظهر') ?? '',
        'العصر': AppPreferences().getString('العصر') ?? '',
        'المغرب': AppPreferences().getString('المغرب') ?? '',
        'العشاء': AppPreferences().getString('العشاء') ?? '',

      };

      datehijri = AppPreferences().getString('datehijri') ?? '';
      datenepali = AppPreferences().getString('datenepali') ?? '';
    });
  }

  String _formatTime(String time24) {
    final DateTime dateTime = DateFormat.Hm().parse(time24);
    return DateFormat.jm().format(dateTime);
  }

  void _handleError(dynamic error) {
    setState(() {
      _loading = false;
      _errorMessage = 'Error: $error';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_errorMessage!), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: tealBlue,
        title: Text('مواقيت الصلاة', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _loading ? _buildLoadingView() : _errorMessage != null ? _buildErrorView() : _buildPrayerTimesList(),
          CustomBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildLoadingView() => Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(tealBlue)));

  Widget _buildErrorView() {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.error, size: 60, color: Colors.red),
        SizedBox(height: 16),
        Text(_errorMessage ?? 'Unknown error occurred.', style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        SizedBox(height: 16),
        ElevatedButton(onPressed: _getCurrentLocation, child: Text('Retry'), style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), textStyle: TextStyle(fontSize: 18))),
      ]),
    );
  }

  Widget _buildPrayerTimesList() {
    return Container(
      color: tealBlue4,
      child: Column(children: [
        Text("$datehijri \n $datenepali", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: navyBlue), textAlign: TextAlign.center),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: _prayerTimes!.entries.map((prayer) {
              return Card(
                color: tealBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 8,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  leading: Icon(Icons.access_time, color: Colors.white),
                  title: Text(prayer.key, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  trailing: Text(prayer.value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
