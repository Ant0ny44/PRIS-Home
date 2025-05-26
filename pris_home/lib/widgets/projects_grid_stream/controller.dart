import 'package:get/get.dart';

class ProjectsGridStreamController extends GetxController {
  ProjectsGridStreamController();

  _initData() {
    update(["projects_grid_steam"]);
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
