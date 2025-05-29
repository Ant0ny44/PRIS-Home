import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pris_home/widgets/project_item/view.dart';
import 'homepage.dart';

class ProjectsPage extends StatelessWidget {
  ProjectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var indexController = Get.put(HomePageIndexController());
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: (() => {indexController.currentIndex.value = 0}),
                  icon: const Icon(Icons.arrow_back)),
              const Expanded(child: Text("")),
              Image.asset(
                "assets/bupt_logo.png",
                height: 64,
              ),
              const Expanded(child: Text("")),
              // IconButton(onPressed: (() => {}), icon: const Icon(Icons.menu)),
            ],
          ),
          ProjectItemPage(),
        ],
      ),
    );
  }
}
