import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

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
  String datehijri = "";
  String datenepali = "";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await _determinePosition();
      setState(() {
        _currentPosition = position;
        _loading = true;
      });
      await _fetchPrayerTimes(position);
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = e.toString();
      });
      _showErrorSnackBar(e.toString());
    }
  }

  String convertTo12HourFormat(String time24) {
    final DateFormat timeFormat24 = DateFormat.Hm();
    final DateFormat timeFormat12 = DateFormat.jm();
    final DateTime dateTime = timeFormat24.parse(time24);
    return timeFormat12.format(dateTime);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  Future<void> _fetchPrayerTimes(Position position) async {
    final latitude = position.latitude;
    final longitude = position.longitude;

    try {
      final dio = Dio();
      final response = await dio.get(
        'https://api.aladhan.com/v1/timings',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'method': 5,
        },
      );

      final data = response.data;
      datehijri = data['data']['date']['readable'];
      datenepali =
          " ${data['data']['date']['hijri']['day']} ${data['data']['date']['hijri']['month']['en']} ${data['data']['date']['hijri']['year']}";

      if (data['code'] == 200) {
        setState(() {
          _prayerTimes = {
            'Fajr': convertTo12HourFormat(data['data']['timings']['Fajr']),
            'Dhuhr': convertTo12HourFormat(data['data']['timings']['Dhuhr']),
            'Asr': convertTo12HourFormat(data['data']['timings']['Asr']),
            'Maghrib':
                convertTo12HourFormat(data['data']['timings']['Maghrib']),
            'Isha': convertTo12HourFormat(data['data']['timings']['Isha']),
          };
          _loading = false;
        });
      } else {
        throw Exception('Failed to load prayer times');
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = 'Failed to load prayer times: $e';
      });
      _showErrorSnackBar(e.toString());
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: tealBlue,
        title: Text(
          'مواقيت الصلاة',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        _loading
            ? _buildLoadingView()
            : _errorMessage != null
                ? _buildErrorView()
                : _buildPrayerTimesList(),
        CustomBottomNavigationBar()
      ]),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(tealBlue),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, size: 60, color: Colors.red),
            SizedBox(height: 16),
            Text(
              _errorMessage ?? 'An unknown error occurred.',
              style: TextStyle(
                  fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _getCurrentLocation();
                setState(() {});
              },
              child: Text('Retry'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTimesList() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [tealBlue2, tealBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Column(
        children: [
          Text(
            "$datehijri \n $datenepali",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: _prayerTimes!.entries.map((prayer) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    leading: Icon(Icons.access_time, color: navyBlue),
                    title: Text(
                      prayer.key,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: navyBlue,
                      ),
                    ),
                    trailing: Text(
                      prayer.value,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: navyBlue,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
