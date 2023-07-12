import 'package:flutter/material.dart';
import 'package:flutterprueba/screens/recycle_bin.dart';

import '../screens/tabs.screen.dart';

class AppRouter {
  Route? onGenerateRouter(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => const RecycleBin());
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_) => const TabsScreen());
      default:
        return null;
    }
  }
}
