import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pris_home/widgets/project_item_thumb/view.dart';
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
        return Obx(() => controller.isLoading.obs.value
            ? const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : controller.videoItemList.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Row(
                        children: [Icon(Icons.hourglass_empty), Text("暂无视频。")],
                      ),
                    ),
                  )
                : Expanded(
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(flex: 2, child: itemInfoList()),
                        Flexible(flex: 1, child: itemList())
                      ],
                    ),
                  ));
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
                Text(
                  controller.mainPlayer.videoName,
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0.0),
              child: Text(
                controller.mainPlayer.videoDescription,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ));
  }

  Widget itemInfoList() {
    return controller.partLoading.obs.value
        ? const Center(child: CircularProgressIndicator())
        : Flex(direction: Axis.vertical, children: [
            Flexible(
              flex: 2,
              child: itemVideoPlayer(),
            ),
            Flexible(flex: 1, child: itemTextInfo()),
          ]);
  }

  Widget itemVideoPlayer() {
    return Column(
      children: [
        Expanded(
          child: controller.videoController.value.isInitialized
              ? Container(
                  padding: const EdgeInsets.all(16.0),
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
    return Obx(() => controller.isLoading.obs.value
        ? const Expanded(child: CircularProgressIndicator())
        : ListView(
            children: List.generate(
                controller.videoItemList.length,
                (index) => ProjectThumbItem(
                      controller.videoItemList[index],
                      playing: controller.videoItemList[index] ==
                          controller.mainPlayer,
                    ))));
  }
}
