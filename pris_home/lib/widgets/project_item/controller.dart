import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import '../../entities/video_item.dart';

class ProjectItemController extends GetxController {
  ProjectItemController();
  late VideoPlayerController videoController;
  late VideoItemEntity mainPlayer;
  List<VideoItemEntity> videoItemList = [];
  bool isLoading = true;
  bool partLoading = false;
  _initData() {
    update(["project_item"]);
    debugPrint('Flush');
  }

  void onTap() {}

  void loadJsonData() async {
    // This function can be used to load JSON data if needed.
    // 在实际应用中，这些视频URL应该从后端获取。
    // 从后段获取JSON字段，这里使用字符串作为Toy Examples。

    // Simulate fetching JSON data from the backend and parsing it.
    Future<void> fetchVideoItems() async {
      await Future.delayed(Duration(seconds: 2), () {
        List<Map<String, dynamic>> jsonResponse = [
          {
            'videoUrl':
                'https://github.com/Ant0ny44/PRIS-Home/raw/refs/heads/main/pris_home/assets/demo1.mp4',
            'videoName': 'Demo Video 1',
            'videoAuthors': 'Author A',
            'videoDescription': 'This is the first demo video.'
          },
          {
            'videoUrl':
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            'videoName': 'Bee Video',
            'videoAuthors': 'Author B',
            'videoDescription': 'A video about bees.'
          },
          {
            'videoUrl':
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
            'videoName': 'Butterfly Video',
            'videoAuthors': 'Author C',
            'videoDescription': 'A video about butterflies.'
          }
        ]; // Replace this with actual parsed JSON data.
        videoItemList =
            jsonResponse.map((json) => VideoItemEntity.fromJson(json)).toList();
        // Convert JSON response to a list of VideoItemEntity.
        // 如果没有获取到视频列表，置空。
        if (videoItemList.isEmpty) {
          videoItemList = [];
          debugPrint('No video items found, initializing with empty list.');
          isLoading = false;
        } else {
          debugPrint('Video items found, initializing with data.');
          // 默认播放第一个Card的视频。
          mainPlayer = videoItemList[0];
          videoController =
              VideoPlayerController.networkUrl(Uri.parse(mainPlayer.videoUrl))
                ..initialize().then((_) {
                  // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                  isLoading = false;
                  update(['project_item']);
                });
        }
      }); // Simulate network delay.
    }

    await fetchVideoItems();
  }

  @override
  void onInit() {
    // 这里写从后段拿取数据的逻辑
    loadJsonData();

    super.onInit();
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
