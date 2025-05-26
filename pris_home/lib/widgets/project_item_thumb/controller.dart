import 'package:get/get.dart';

class ProjectThumbItemController extends GetxController {
  ProjectThumbItemController();
  late String projectName;
  late String projectDescription;
  late String projectVideoUrl;
  late String projectAuthors;
  _initData() {
    update(["project_thumb_item"]);
  }

  void onTap() {}

  @override
  void onInit() {
    projectName = 'Default Project Name';
    projectDescription = 'Default Project Description. ';
    projectVideoUrl =
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
    projectAuthors = 'Default Authors';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
