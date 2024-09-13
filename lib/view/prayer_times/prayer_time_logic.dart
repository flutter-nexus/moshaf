import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:moshaf/service/shared_prefrece.dart';

// تحديد الموقع
Future<Position> determinePosition() async {
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

// جلب مواقيت الصلاة
Future<void> fetchPrayerTimes(
    Position position,
    Function(Map<String, String>, String, String) onSuccess,
    Function(dynamic) onError) async {
  try {
    final response = await Dio().get('https://api.aladhan.com/v1/timings',
        queryParameters: {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'method': 5
        });

    final data = response.data['data'];
    Map<String, String> prayerTimes = {
      'الفجر': _formatTime(data['timings']['Fajr']),
      'الظهر': _formatTime(data['timings']['Dhuhr']),
      'العصر': _formatTime(data['timings']['Asr']),
      'المغرب': _formatTime(data['timings']['Maghrib']),
      'العشاء': _formatTime(data['timings']['Isha']),
    };

    String dateHijri =
        "${data['date']['hijri']['day']} ${data['date']['hijri']['month']['en']} ${data['date']['hijri']['year']}";
    String dateNepali = data['date']['readable'];

    await savePrayerTimes(
        prayerTimes, dateHijri, dateNepali); // حفظ مواقيت الصلاة

    onSuccess(prayerTimes, dateHijri, dateNepali); // إرسال البيانات للواجهة
  } catch (e) {
    onError(e);
  }
}

// حفظ مواقيت الصلاة في SharedPreferences
Future<void> savePrayerTimes(Map<String, String> prayerTimes, String dateHijri,
    String dateNepali) async {
  await AppPreferences().init(); // تأكد من تهيئة AppPreferences

  for (var entry in prayerTimes.entries) {
    await AppPreferences()
        .saveString(entry.key, entry.value); // حفظ كل وقت صلاة
  }

  await AppPreferences().saveString('datehijri', dateHijri);
  await AppPreferences().saveString('datenepali', dateNepali);
}

// استرجاع مواقيت الصلاة من SharedPreferences
Future<_PrayerTimesResult> loadPrayerTimes() async {
  await AppPreferences().init();

  Map<String, String> prayerTimes = {
    'الفجر': AppPreferences().getString('الفجر') ?? '',
    'الظهر': AppPreferences().getString('الظهر') ?? '',
    'العصر': AppPreferences().getString('العصر') ?? '',
    'المغرب': AppPreferences().getString('المغرب') ?? '',
    'العشاء': AppPreferences().getString('العشاء') ?? '',
  };

  String dateHijri = AppPreferences().getString('datehijri') ?? '';
  String dateNepali = AppPreferences().getString('datenepali') ?? '';

  return _PrayerTimesResult(prayerTimes, dateHijri, dateNepali);
}

String _formatTime(String time24) {
  final DateTime dateTime = DateFormat.Hm().parse(time24);
  return DateFormat.jm().format(dateTime);
}

class _PrayerTimesResult {
  final Map<String, String> prayerTimes;
  final String dateHijri;
  final String dateNepali;

  _PrayerTimesResult(this.prayerTimes, this.dateHijri, this.dateNepali);
}
