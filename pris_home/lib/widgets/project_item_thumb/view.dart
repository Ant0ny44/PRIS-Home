import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class ProjectThumbItem extends GetView<ProjectThumbItemController> {
  const ProjectThumbItem({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("project_thumb_item"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectThumbItemController>(
      init: ProjectThumbItemController(),
      id: "project_thumb_item",
      builder: (_) {
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.work),
                title: Text(controller.projectName),
                subtitle: Text(controller.projectAuthors),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () => {},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('More'),
                    onPressed: () {
                      /* ... */
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
