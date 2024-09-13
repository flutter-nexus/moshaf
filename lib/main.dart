import 'imports/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize((String? payload) {
    // هنا يمكنك التعامل مع الإشعار عند النقر عليه
  });
  await WorkManagerService().init();
runApp(GetMaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));}

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
