import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pris_home/widgets/project_item_thumb/view.dart';
import 'package:video_player/video_player.dart';
import '../../pages/homepage.dart';
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
                : controller.windowsFullScreen
                    ? Expanded(child: itemInfoList())
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
                  controller.videoItemList[controller.currentIndex].videoName,
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
                controller
                    .videoItemList[controller.currentIndex].videoDescription,
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
            controller.windowsFullScreen
                ? const Text('')
                : Flexible(flex: 1, child: itemTextInfo()),
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
        child: Column(
          children: [
            controller.videoController.value.isInitialized
                ? GetBuilder<ProjectItemController>(
                    init: ProjectItemController(),
                    id: "video_slider",
                    builder: (_) {
                      return Slider(
                          value: controller.videoController.value.position
                              .inSeconds.obs.value
                              .toDouble(),
                          min: 0.0,
                          max: controller
                              .videoController.value.duration.inSeconds
                              .toDouble(),
                          onChanged: ((value) {
                            controller.videoController
                                .seekTo(Duration(seconds: value.toInt()));
                            controller.update(['project_item']);
                          }));
                    },
                  )
                : const Text(""),
            Row(
              children: [
                IconButton(
                  onPressed: (() => {controller.playPreviousVideo()}),
                  icon: const Icon(Icons.skip_previous_sharp),
                ),
                IconButton(
                  onPressed: controller.togglePlayPauseBtn,
                  icon: Icon(controller.videoController.value.isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded),
                ),
                IconButton(
                  onPressed: (() => {controller.playNextVideo()}),
                  icon: const Icon(Icons.skip_next_sharp),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(24.0, 0, 8.0, 0),
                  child: Text("自动连播"),
                ),
                Switch(
                  value: controller.autoPlayNext.obs.value,
                  onChanged: (value) {
                    controller.autoPlayNext = value;
                    controller.update(['project_item']);
                  },
                ),
                const Expanded(child: Text("")),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.fullscreen),
                //   tooltip: '全屏',
                // ),
                IconButton(
                  onPressed: () {
                    controller.windowsFullScreen =
                        !controller.windowsFullScreen;
                    var navigationController =
                        Get.find<HomePageIndexController>();
                    navigationController.fullScreen.value =
                        controller.windowsFullScreen;
                    controller.update(['project_item']);
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    child: controller.windowsFullScreen
                        ? const Icon(Icons.fullscreen_exit_rounded)
                        : const Icon(Icons.fullscreen_rounded),
                  ),
                  tooltip: controller.windowsFullScreen ? '退出全屏' : '窗口全屏',
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: controller.volumeDown,
                        icon: const Icon(Icons.volume_down),
                        tooltip: '降低音量',
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        width: Get.width * 0.1,
                        child: LinearProgressIndicator(
                          value: controller.volume.obs.value,
                        ),
                      ),
                      IconButton(
                        onPressed: controller.volumeUp,
                        icon: const Icon(Icons.volume_up),
                        tooltip: '增大音量',
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.videoController.seekTo(
                        controller.videoController.value.position -
                            const Duration(seconds: 10));
                  },
                  icon: const Icon(Icons.replay_10),
                ),

                IconButton(
                  onPressed: (() {
                    if (controller.videoController.value.isInitialized) {
                      controller.videoController
                          .seekTo(Duration.zero); // Reset video to start
                      controller.videoController.play();
                    }
                  }),
                  icon: const Icon(Icons.replay),
                ),
                IconButton(
                  onPressed: () {
                    controller.videoController.seekTo(
                        controller.videoController.value.position +
                            const Duration(seconds: 10));
                  },
                  icon: const Icon(Icons.forward_10),
                ),
              ],
            )
          ],
        ));
  }

  Widget itemList() {
    return Obx(() => controller.isLoading.obs.value
        ? const Expanded(child: CircularProgressIndicator())
        : ListView(
            children: List.generate(
                controller.videoItemList.length,
                (index) => GetBuilder<ProjectItemController>(
                    init: ProjectItemController(),
                    id: "item_list",
                    builder: (_) {
                      return ProjectThumbItem(
                        controller.videoItemList[index],
                        playing: index == controller.currentIndex,
                        itemIndex: index,
                      );
                    }))));
  }
}
