import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class ProjectsGridStreamPage extends GetView<ProjectsGridStreamController> {
  const ProjectsGridStreamPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("ProjectsGridStreamPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectsGridStreamController>(
      init: ProjectsGridStreamController(),
      id: "projects_grid_steam",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("ProjectsGridSteamController")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
