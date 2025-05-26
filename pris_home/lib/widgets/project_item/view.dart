import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'index.dart';
import 'dart:html';

class ProjectItemPage extends GetView<ProjectItemController> {
  const ProjectItemPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("ProjectItemPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectItemController>(
      init: ProjectItemController(),
      id: "project_item",
      builder: (_) {
        return Card(
          child: itemInfoList(),
        );
      },
    );
  }
}

Widget itemInfoList() {
  return const Column(children: [
    ItemVideoPlayer(),
    SizedBox(height: 16.0),
    Text(
      "This is a sample project item. It contains a video player that plays a sample video.",
      style: TextStyle(fontSize: 16.0),
    ),
    SizedBox(height: 16.0),
  ]);
}

class ItemVideoPlayer extends StatefulWidget {
  const ItemVideoPlayer({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<ItemVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Obx((() => SizedBox(
          height: Get.height.obs.value * 0.8,
          width: Get.width.obs.value * 0.4,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 32.0, 32.0, 32.0),
                child: SizedBox(
                  width: Get.width * 0.2,
                  height: Get.height * 0.5,
                  child: _controller.value.isInitialized
                      ? VideoPlayer(_controller)
                      : const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ),
              ),
              videoControllerBuilder(),
            ],
          ),
        )));
  }

  Widget videoControllerBuilder() {
    return SizedBox(
      height: 32.0,
      child: Row(
        children: [
          IconButton(
            onPressed: (() => {
                  if (_controller.value.isInitialized)
                    {
                      setState(() {
                        _controller
                            .seekTo(Duration.zero); // Reset video to start
                        _controller.play();
                      })
                    }
                }),
            icon: const Icon(Icons.replay),
          ),
          const Expanded(child: Text("")),
          IconButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _controller.seekTo(
                    _controller.value.position + const Duration(seconds: 10));
              });
            },
            icon: const Icon(Icons.forward_10),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _controller.seekTo(
                    _controller.value.position - const Duration(seconds: 10));
              });
            },
            icon: const Icon(Icons.replay_10),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
