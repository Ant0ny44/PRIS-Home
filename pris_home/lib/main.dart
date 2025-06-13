import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pris_home/pages/homepage.dart';
import 'package:pris_home/constants.dart';
import 'package:pris_home/pages/projects.dart';

void main() => runApp(GetMaterialApp(
      // home: Home(),
      home: ProjectsPage(),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: ColorSeed.blue.color,
        brightness: Brightness.light,
      ),
      translations: Messages(),
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('en', 'US'),
    ));
