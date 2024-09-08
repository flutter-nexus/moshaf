import 'imports/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([WorkManagerService().init(), Notifications().init()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}