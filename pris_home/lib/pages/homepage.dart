import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pris_home/pages/projects.dart';
import 'package:pris_home/pages/publications.dart';

import 'groups.dart';

class HomePageIndexController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}

class HomepageNavigator extends StatelessWidget {
  HomepageNavigator({super.key});
  var indexController = Get.put(HomePageIndexController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => NavigationRail(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(14.0, 28.0, 14.0, 28.0),
            child: Text('rail_title'.tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
          groupAlignment: -1.0,
          labelType: NavigationRailLabelType.all,
          destinations: <NavigationRailDestination>[
            NavigationRailDestination(
              icon: const Icon(Icons.home),
              selectedIcon: const Icon(Icons.home_outlined),
              label: Text('rail_home_btn'.tr),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.group),
              selectedIcon: const Icon(Icons.group_outlined),
              label: Text('rail_groups_btn'.tr),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.book),
              selectedIcon: const Icon(Icons.bookmark_outline),
              label: Text('rail_publications_btn'.tr),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.workspaces),
              selectedIcon: const Icon(Icons.workspaces_outline),
              label: Text('rail_projects_btn'.tr),
            ),
          ],
          selectedIndex: indexController.currentIndex.value,
          onDestinationSelected: (value) => indexController.changeIndex(value),
        ));
  }
}

class Home extends StatelessWidget {
  Home({super.key});
  var mainViewList = <Widget>[
    HomePage(),
    GroupsPage(),
    PublicationsPage(),
    ProjectsPage()
  ];
  var indexController = Get.put(HomePageIndexController());
  @override
  Widget build(context) {
    return Scaffold(
      body: Row(
        children: [
          HomepageNavigator(),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Obx(() => mainViewList[indexController.currentIndex.value]),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Research Group'),
        ),
        body: const Text("TODO"));
  }
}
