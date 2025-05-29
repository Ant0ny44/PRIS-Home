import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:pris_home/entities/video_item.dart';
import 'package:pris_home/widgets/project_item/index.dart';
import 'package:video_player/video_player.dart';

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';

// 获取视频缩略图作为封面。
class GenThumbnailImage extends StatefulWidget {
  const GenThumbnailImage({
    Key? key,
    required this.thumbnailRequest,
  }) : super(key: key);
  final ThumbnailRequest thumbnailRequest;

  @override
  State<GenThumbnailImage> createState() => _GenThumbnailImageState();
}

class ThumbnailRequest {
  const ThumbnailRequest({
    required this.video,
    required this.thumbnailPath,
    required this.imageFormat,
    required this.maxHeight,
    required this.maxWidth,
    required this.timeMs,
    required this.quality,
    required this.attachHeaders,
  });

  final String video;
  final String? thumbnailPath;
  final ImageFormat imageFormat;
  final int maxHeight;
  final int maxWidth;
  final int timeMs;
  final int quality;
  final bool attachHeaders;
}

class ThumbnailResult {
  const ThumbnailResult({
    required this.image,
    required this.dataSize,
    required this.height,
    required this.width,
  });

  final Image image;
  final int dataSize;
  final int height;
  final int width;
}

Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
  Uint8List bytes;
  final completer = Completer<ThumbnailResult>();
  if (r.thumbnailPath != null) {
    final thumbnailFile = await VideoThumbnail.thumbnailFile(
      video: r.video,
      headers: r.attachHeaders
          ? const {
              'USERHEADER1': 'user defined header1',
              'USERHEADER2': 'user defined header2',
            }
          : null,
      thumbnailPath: r.thumbnailPath,
      imageFormat: r.imageFormat,
      maxHeight: r.maxHeight,
      maxWidth: r.maxWidth,
      timeMs: r.timeMs,
      quality: r.quality,
    );

    debugPrint('thumbnail file is located: $thumbnailFile');

    bytes = await thumbnailFile.readAsBytes();
  } else {
    bytes = await VideoThumbnail.thumbnailData(
      video: r.video,
      headers: r.attachHeaders
          ? const {
              'USERHEADER1': 'user defined header1',
              'USERHEADER2': 'user defined header2',
            }
          : null,
      imageFormat: r.imageFormat,
      maxHeight: r.maxHeight,
      maxWidth: r.maxWidth,
      timeMs: r.timeMs,
      quality: r.quality,
    );
  }

  final imageDataSize = bytes.length;
  debugPrint('image size: $imageDataSize');

  final image = Image.memory(bytes);
  image.image.resolve(ImageConfiguration.empty).addListener(
        ImageStreamListener(
          (ImageInfo info, bool _) {
            completer.complete(
              ThumbnailResult(
                image: image,
                dataSize: imageDataSize,
                height: info.image.height,
                width: info.image.width,
              ),
            );
          },
          onError: completer.completeError,
        ),
      );
  return completer.future;
}

class _GenThumbnailImageState extends State<GenThumbnailImage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThumbnailResult>(
      future: genThumbnail(widget.thumbnailRequest),
      builder: (BuildContext context, AsyncSnapshot<ThumbnailResult> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          final image = data.image;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              image,
            ],
          );
        } else if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(8),
            // color: Colors.red,
            child: const Text('加载缩略图失败'),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ProjectThumbItem extends StatelessWidget {
  final VideoItemEntity videoItem;
  bool playing = false;
  ProjectThumbItem(this.videoItem, {super.key, this.playing = false});
  @override
  Widget build(BuildContext context) {
    debugPrint(playing.toString());
    return Obx(() => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastEaseInToSlowEaseOut,
        padding: const EdgeInsets.all(8.0),
        height: playing.obs.value ? 188.0 : 164.0,
        width: playing.obs.value ? Get.width * 0.38 : Get.width * 0.3,
        child: Card(
          color: playing.obs.value
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).cardColor,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GenThumbnailImage(
                        thumbnailRequest: ThumbnailRequest(
                          video: videoItem.videoUrl,
                          thumbnailPath: null,
                          imageFormat: ImageFormat.JPEG,
                          maxHeight: (constraints.maxHeight * 0.85).toInt(),
                          maxWidth: (playing.obs.value
                                  ? Get.width * 0.38
                                  : Get.width * 0.3)
                              .toInt(),
                          timeMs: 0,
                          quality: 75,
                          attachHeaders: false,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        videoItem.videoName,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(videoItem.videoAuthors),
                      Text(videoItem.videoDescription),
                    ],
                  ),
                ),
                const Expanded(child: Text("")),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: Column(
                    children: [
                      const Expanded(child: Text("")),
                      IconButton(
                        icon: const Icon(Icons.play_arrow_sharp),
                        onPressed: () {
                          var mainPlayerController =
                              Get.find<ProjectItemController>();
                          mainPlayerController.partLoading = true;
                          mainPlayerController.mainPlayer = videoItem;
                          mainPlayerController.update(["project_item"]);
                          mainPlayerController.videoController =
                              VideoPlayerController.networkUrl(
                                  Uri.parse(videoItem.videoUrl))
                                ..initialize().then((_) {
                                  mainPlayerController.partLoading = false;
                                  mainPlayerController.videoController.play();
                                  mainPlayerController.update(["project_item"]);
                                });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
