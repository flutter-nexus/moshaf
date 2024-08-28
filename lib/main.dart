import 'imports/imports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TeachingPrayScreen(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> titles = [
    'Home Screen',
    'Login Screen',
    'Signup Screen',
    'Reset Password Screen',
    'Verification Code Screen',
    'Settings Screen',
    'Time of Prayer Screen',
    'Quran Index Screen',
    'Hadith Screen',
    'Quran Page Verse',
  ];
  final List<Widget> pages = [
    HomeScreen(),
    LoginScreen(),
    SignUpScreen(),
    ResetPasswordScreen(),
    VerificationCodeInput(
      controller: TextEditingController(),
      onCompleted: (value) {
        print(value);
      },
    ),
    SettingsScreen(),
    PrayerTimeScreen(),
    QuranIndexPage(),
    Hadith(),
    QuranPageVersePreview( indexSurah: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('page  List'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Center(child: Text(titles[index])),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return pages[index];
                  }),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
