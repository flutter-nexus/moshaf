import 'imports/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize((String? payload) {
    // هنا يمكنك التعامل مع الإشعار عند النقر عليه
  });
  await WorkManagerService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('WorkManager & Notifications'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
