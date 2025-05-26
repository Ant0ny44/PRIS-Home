import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pris_home/widgets/project_item/view.dart';
import 'homepage.dart';

class ProjectsPage extends StatelessWidget {
  ProjectsPage({Key? key}) : super(key: key);
  var indexController = Get.put(HomePageIndexController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: (() =>
                          {indexController.currentIndex.value = 0}),
                      icon: const Icon(Icons.arrow_back)),
                  const Expanded(child: Text("")),
                  IconButton(
                      onPressed: (() => {}), icon: const Icon(Icons.menu)),
                ],
              ),
              ProjectItemPage(),
            ],
          ),
        ),
      ),
    ));
  }
}
