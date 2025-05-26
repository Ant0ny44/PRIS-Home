import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class ProjectItemController extends GetxController {
  ProjectItemController();
  late VideoPlayerController videoController;
  _initData() {
    update(["project_item"]);
    debugPrint('Flush');
  }

  void onTap() {}

  @override
  void onInit() {
    videoController = VideoPlayerController.networkUrl(Uri.parse(
        'https://github.com/Ant0ny44/PRIS-Home/raw/refs/heads/main/pris_home/assets/demo1.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        super.onInit();
      });
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
