import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pris_home/widgets/project_item_thumb/index.dart';
import 'package:video_player/video_player.dart';
import 'index.dart';

class ProjectItemPage extends GetView<ProjectItemController> {
  const ProjectItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectItemController>(
      init: ProjectItemController(),
      id: "project_item",
      builder: (_) {
        return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [itemInfoList(), itemList()],
            )));
      },
    );
  }

  Widget itemTextInfo() {
    return Container(
        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Project Title",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0.0),
              child: const Text(
                "Here are the details of this project. Balabala, this is a demo project to show how to use the video player in Flutter. You can play, pause, and seek through the video. Here are the details of this project. Balabala, this is a demo project to show how to use the video player in Flutter. You can play, pause, and seek through the video. Here are the details of this project. Balabala, this is a demo project to show how to use the video player in Flutter. You can play, pause, and seek through the video.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ));
  }

  Widget itemInfoList() {
    return SizedBox(
        height: Get.height * 0.9,
        width: Get.width * 0.4,
        child: Column(children: [
          itemVideoPlayer(),
          itemTextInfo(),
        ]));
  }

  Widget itemVideoPlayer() {
    return Column(
      children: [
        Container(
          height: Get.height * 0.3,
          width: Get.width * 0.6,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 4.0),
          child: controller.videoController.value.isInitialized
              ? VideoPlayer(controller.videoController)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        videoControllerBuilder(),
      ],
    );
  }

  Widget videoControllerBuilder() {
    return Container(
        padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0.0),
        child: Row(
          children: [
            IconButton(
              onPressed: (() => {
                    controller.videoController.value.isInitialized
                        ? controller.videoController.seekTo(Duration.zero)
                        : // Reset video to start
                        controller.videoController.play()
                  }),
              icon: const Icon(Icons.replay),
            ),
            const Expanded(child: Text("")),
            Obx(() => IconButton(
                  onPressed: () {
                    controller.update(['project_item']);
                    controller.videoController.value.isPlaying
                        ? controller.videoController.pause()
                        : controller.videoController.play();
                  },
                  icon: Icon(
                    controller.videoController.value.isPlaying.obs.value
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                )),
            IconButton(
              onPressed: () {
                controller.videoController.seekTo(
                    controller.videoController.value.position +
                        const Duration(seconds: 10));
              },
              icon: const Icon(Icons.forward_10),
            ),
            IconButton(
              onPressed: () {
                controller.videoController.seekTo(
                    controller.videoController.value.position -
                        const Duration(seconds: 10));
              },
              icon: const Icon(Icons.replay_10),
            ),
          ],
        ));
  }

  Widget itemList() {
    return Container(
      height: Get.height * 0.9,
      width: Get.width * 0.4,
      child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3.3, // ratio = 宽度 / 高度
            crossAxisSpacing: 8,
            mainAxisSpacing: 3,
          ),
          children: List.generate(100, (index) => ProjectThumbItem())),
    );
  }
}
