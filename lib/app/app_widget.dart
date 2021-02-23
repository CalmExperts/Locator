import 'package:flutter/material.dart';
import 'package:locator/app/features/account/account_page.dart';

import 'app_injections.dart';
import 'features/map/map_page.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  AppInjections appInjections = AppInjections();

  @override
  void initState() {
    appInjections.registerSingleton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Locator",
      theme: ThemeData.dark(),
      home: MapPage(),
    );
  }
}
