import 'package:moshaf/imports/imports.dart';

class MuslimAppController extends GetxController {
  var selectedIndex = 0.obs;
  Icon audioIcon = const Icon(Icons.play_arrow);

  void setIndex(int index) {
    selectedIndex.value = index;
  }
}
