import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class ProjectItemController extends GetxController {
  ProjectItemController();
  late VideoPlayerController videoController;
  late List<String> videoUrlList;
  _initData() {
    update(["project_item"]);
    debugPrint('Flush');
  }

  void onTap() {}

  @override
  void onInit() {
    // 这里写从后段拿取数据的逻辑
    videoUrlList = [
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
    ]; // Toy example video URLs.

    //TODO: 使用video_player 和 screenshot获取视频的第一帧作为封面。

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
