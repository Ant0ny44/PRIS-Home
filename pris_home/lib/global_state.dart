import 'package:get/get.dart';
import 'package:pris_home/constants.dart';

class GlobalState extends GetxController {
  var themeSeed = ColorSeed.baseColor.obs;
  var lightMode = true.obs;

  GlobalState() {
    initializeAsync();
  }
  void initializeAsync() async {}
}
