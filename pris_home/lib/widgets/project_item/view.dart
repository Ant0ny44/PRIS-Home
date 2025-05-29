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
        return Expanded(
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: itemInfoList()),
              Flexible(child: itemList())
            ],
          ),
        );
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
    return Flex(direction: Axis.vertical, children: [
      Flexible(child: itemVideoPlayer()),
      Flexible(child: itemTextInfo()),
    ]);
  }

  Widget itemVideoPlayer() {
    return Column(
      children: [
        Expanded(
          // width: Get.width * .3,
          // height: Get.height * .3,
          // padding: const EdgeInsets.fromLTRB(0, 0, 0, 4.0),
          child: controller.videoController.value.isInitialized
              ? Container(
                  padding: EdgeInsets.all(16.0),
                  child: AspectRatio(
                    aspectRatio: controller.videoController.value.aspectRatio,
                    // Use the VideoPlayer widget to display the video.
                    child: VideoPlayer(controller.videoController),
                  ),
                )
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
    return ListView(children: List.generate(5, (index) => ProjectThumbItem()));
  }
}
