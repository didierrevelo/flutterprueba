// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterprueba/providers/api_provider.dart';
import 'package:flutterprueba/screens/character_screen.dart';
import 'package:flutterprueba/screens/recycle_bin.dart';
import 'package:flutterprueba/screens/rick_and_morty.dart';
import 'package:flutterprueba/screens/tabs.screen.dart';
import 'package:flutterprueba/services/app_router.dart';
import 'package:flutterprueba/services/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'blocs/bloc.exports.dart';
import 'models/character.model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

final GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const RickMorty();
      },
      routes: [
        GoRoute(
          path: 'tabs',
          builder: (context, state) {
            return const TabsScreen();
          },
        ),
        GoRoute(
          path: 'rickAndMorty',
          builder: (context, state) {
            return const RickMorty();
          },
        ),
        GoRoute(
          path: 'character',
          builder: (context, state) {
            final character = state.extra as Character;
            return  CharacterScreen(
              character: character,
            );
          },
        ),
        GoRoute(
          path: 'reciclebin',
          builder: (context, state) {
            return const RecycleBin();
          },
        )
      ]),
]);

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBlocBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (context) => ApiProvider(),
            child: MaterialApp.router(
              title: 'Material App',
              theme: state.switchValue
                  ? AppThemes.appThemeData[AppTheme.darkTheme]
                  : AppThemes.appThemeData[AppTheme.lightTheme],
              routerConfig: _router,
            ),
          );
        },
      ),
    );
  }
}
