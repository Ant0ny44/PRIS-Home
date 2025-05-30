import 'package:get/get.dart';

class FullScreenController extends GetxController {
  FullScreenController();

  _initData() {
    update(["full_screen"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
