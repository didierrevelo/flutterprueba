import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutterprueba/screens/character_screen.dart';
import 'package:flutterprueba/screens/recycle_bin.dart';
import 'package:flutterprueba/screens/rick_and_morty.dart';

import '../screens/tabs.screen.dart';

class AppRouter {
  Route? onGenerateRouter(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => const RecycleBin());
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_) => const TabsScreen());
      case RickMorty.id:
        return MaterialPageRoute(builder: (_) => const RickMorty());
      default:
        return null;
    }
  }
}
