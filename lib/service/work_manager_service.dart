import 'package:moshaf/service/notifcation.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  void registerTask() async {
    await Workmanager().registerOneOffTask("id 1", "simpleTask");
  }

  Future<void> init() async {
    await Workmanager().initialize(
      actionTask,
      isInDebugMode: true,
    );
    registerTask();
  }

  void cancel() {
    Workmanager().cancelAll();
  }
}

@pragma('vm:entry-point')
void actionTask() {
  Workmanager().executeTask((task, inputData) async {
    Notifications().showNotifications();
    return Future.value(true);
  });
}
