import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import '../../entities/video_item.dart';

class ProjectItemController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ProjectItemController();
  late VideoPlayerController videoController;
  late AnimationController animationController;

  List<VideoItemEntity> videoItemList = [];
  int currentIndex = 0;
  bool isLoading = true;
  bool partLoading = false;
  double volume = 0.8;
  bool autoPlayNext = true;
  bool windowsFullScreen = false;
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

    await Future.delayed(const Duration(seconds: 0), () {
      List<Map<String, dynamic>> jsonResponse = [
        {
          'videoUrl': 'assets/demo2.mp4',
          'videoName': 'Bee Video',
          'videoAuthors': 'Author B',
          'videoDescription': 'A video about bees.'
        },
        {
          'videoUrl': 'assets/demo3.mp4',
          'videoName': 'Butterfly Video',
          'videoAuthors': 'Author C',
          'videoDescription': 'A video about butterflies.'
        },
        {
          'videoUrl': 'assets/demo4.mp4',
          'videoName': 'Butterfly Video',
          'videoAuthors': 'Author C',
          'videoDescription': 'A video about butterflies.'
        },
        {
          'videoUrl': 'assets/demo5.mp4',
          'videoName': 'Butterfly Video',
          'videoAuthors': 'Author C',
          'videoDescription': 'A video about butterflies.'
        },
        {
          'videoUrl': 'assets/demo6.mp4',
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
        videoController = VideoPlayerController.asset(videoItemList[0].videoUrl)
          ..initialize().then((_) {
            videoController.setLooping(false);
            videoController.play();
            videoController.addListener(_videoListener);
            videoController.setVolume(volume);
            isLoading = false;
            update(['project_item']);
          });
        // videoController = VideoPlayerController.networkUrl(
        //     Uri.parse(videoItemList[currentIndex].videoUrl))
        //   ..initialize().then((_) {
        //     videoController.setLooping(false);
        //     videoController.play();
        //     videoController.addListener(_videoListener);
        //     videoController.setVolume(volume);
        //     isLoading = false;
        //     update(['project_item']);
        //   });
      }
    }); // Simulate network delay.
  }

  @override
  void onInit() {
    // 这里写从后段拿取数据的逻辑
    loadJsonData();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
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
    animationController.dispose();
    super.onClose();
  }

  void togglePlayPauseBtn() {
    {
      if (videoController.value.isPlaying) {
        animationController.forward();
        videoController.pause();
      } else {
        animationController.reverse();
        videoController.play();
      }
      update(['project_item']);
    }
  }

  void _videoListener() {
    update(['video_slider']);
    if (videoController.value.position >= videoController.value.duration) {
      if (autoPlayNext) {
        videoController.removeListener(_videoListener);
        playNextVideo();
      }
    }
  }

  void volumeUp() {
    volume = volume >= 1.0 ? 1.0 : volume + 0.1;
    videoController.setVolume(volume);

    update(['project_item']);
  }

  void volumeDown() {
    volume = volume <= 0 ? 0 : volume - 0.1;
    videoController.setVolume(volume);

    update(['project_item']);
  }

  void playPreviousVideo() {
    currentIndex =
        (currentIndex - 1 + videoItemList.length) % videoItemList.length;
    initializeVideo(currentIndex);
  }

  void playNextVideo() {
    currentIndex = (currentIndex + 1) % videoItemList.length;

    initializeVideo(currentIndex);
  }

  Future<void> initializeVideo(int index) async {
    partLoading = true;
    update(['project_item', "item_list"]);
    await videoController.pause();
    await videoController.dispose();

    currentIndex = index;
    videoController =
        VideoPlayerController.asset(videoItemList[currentIndex].videoUrl)
          ..initialize().then((_) {
            videoController.setLooping(false);
            videoController.setVolume(volume);
            videoController.play();
            videoController.addListener(_videoListener);
            partLoading = false;
            update(['project_item', 'item_list']);
          });
  }
}
