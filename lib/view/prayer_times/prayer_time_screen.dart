import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../../imports/imports.dart';
import 'prayer_time_logic.dart'; // استيراد ملف الدوال

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
      _currentPosition = await determinePosition(); // استدعاء دالة من ملف logic
      setState(() => _loading = true);
      await fetchPrayerTimes(_currentPosition!,
          (prayerTimes, hijriDate, nepaliDate) {
        setState(() {
          _prayerTimes = prayerTimes;
          datehijri = hijriDate;
          datenepali = nepaliDate;
          _loading = false;
        });
      }, _handleError);
    } catch (e) {
      _handleError(e);
    }
  }

  // استرجاع مواقيت الصلاة من SharedPreferences
  Future<void> _loadPrayerTimes() async {
    final result = await loadPrayerTimes(); // استدعاء الدالة من ملف logic
    setState(() {
      _prayerTimes = result.prayerTimes;
      datehijri = result.dateHijri;
      datenepali = result.dateNepali;
    });
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
        title: Text('مواقيت الصلاة',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _loading
              ? _buildLoadingView()
              : _errorMessage != null
                  ? _buildErrorView()
                  : _buildPrayerTimesList(),
          CustomBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildLoadingView() => Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(tealBlue)));

  Widget _buildErrorView() {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.error, size: 60, color: Colors.red),
        SizedBox(height: 16),
        Text(_errorMessage ?? 'Unknown error occurred.',
            style: TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        SizedBox(height: 16),
        ElevatedButton(
            onPressed: _getCurrentLocation,
            child: Text('Retry'),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 18))),
      ]),
    );
  }

  Widget _buildPrayerTimesList() {
    return Container(
      color: tealBlue4,
      child: Column(children: [
        Text("$datehijri \n $datenepali",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: navyBlue),
            textAlign: TextAlign.center),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: _prayerTimes!.entries.map((prayer) {
              return Card(
                color: tealBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 8,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  leading: Icon(Icons.access_time, color: Colors.white),
                  title: Text(prayer.key,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  trailing: Text(prayer.value,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
