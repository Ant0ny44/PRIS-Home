import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_thumbnail_video/index.dart';

import 'index.dart';

class ProjectThumbItem extends GetView<ProjectThumbItemController> {
  const ProjectThumbItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectThumbItemController>(
      init: ProjectThumbItemController(),
      id: "project_thumb_item",
      builder: (_) {
        return Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: GenThumbnailImage(
                  thumbnailRequest: ThumbnailRequest(
                    video: controller.projectVideoUrl,
                    thumbnailPath: null,
                    imageFormat: ImageFormat.JPEG,
                    maxHeight: 84,
                    maxWidth: 84,
                    timeMs: 0,
                    quality: 75,
                    attachHeaders: false,
                  ),
                ),
                title: Text(controller.projectName),
                subtitle: Text(controller.projectAuthors),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
