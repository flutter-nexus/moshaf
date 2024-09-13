import 'package:workmanager/workmanager.dart';
import 'notifcation.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'sendPrayerNotification') {
      final prayerName = inputData?['prayerName'] ?? 'Unknown Prayer';
      await NotificationService.showAzanNotification(prayerName);
    }
    return Future.value(true);
  });
}

class WorkManagerService {
  Future<void> init() async {
    Workmanager().initialize(callbackDispatcher);
  }

  Future<void> schedulePrayerNotification(
      String prayerName, DateTime scheduledTime) async {
    await Workmanager().registerOneOffTask(
      'id_unique_task', // يجب أن يكون معرف المهمة فريداً
      'sendPrayerNotification',
      inputData: {'prayerName': prayerName},
      initialDelay: scheduledTime.difference(DateTime.now()), // تأخير الموعد
      constraints: Constraints(
        networkType: NetworkType.not_required,
      ),
    );
  }
}
