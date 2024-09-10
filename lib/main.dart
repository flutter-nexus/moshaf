import 'imports/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([WorkManagerService().init(), Notifications().init()]);
  runApp(GetMaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MuslimAppController>(
      init: MuslimAppController(),
      builder: (controller) => Scaffold(body: HomeScreen()),
    );
  }
}
