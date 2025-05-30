import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class FullScreenPage extends GetView<FullScreenController> {
  const FullScreenPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("FullScreenPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FullScreenController>(
      init: FullScreenController(),
      id: "full_screen",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("full_screen")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
