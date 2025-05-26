import 'package:get/get.dart';

class ProjectItemController extends GetxController {
  ProjectItemController();

  _initData() {
    update(["project_item"]);
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
