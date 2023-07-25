import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../blocs/bloc.exports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.blue,
              child: Text(
                'TasksApp',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            BlocBuilder<TasksBlocBloc, TasksBlocState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => context.go('/tabs'),
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text("My Tasks"),
                    trailing: Text(
                        '${state.pendingTasks.length} | ${state.completedTasks.length}'),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBlocBloc, TasksBlocState>(
                builder: (context, state) {
              return GestureDetector(
                onTap: () => context.go('/reciclebin'),
                child: ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text("Historial"),
                  trailing: Text('${state.removedTasks.length}'),
                ),
              );
            }),
            const Divider(),
            BlocBuilder<TasksBlocBloc, TasksBlocState>(
                builder: (context, state) {
              return GestureDetector(
                onTap: () => context.go('/rickAndMorty'),
                child: const ListTile(
                  leading: Icon(Icons.manage_search),
                  title: Text("Rick and Morty APP"),
                ),
              );
            }),
            const Divider(),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                const ListTile(
                    leading: Icon(Icons.dark_mode_outlined),
                    title: Text("Tema"));
                return Switch(
                    value: state.switchValue,
                    onChanged: (newValue) {
                      newValue
                          ? context.read<SwitchBloc>().add(SwitchOnEvent())
                          : context.read<SwitchBloc>().add(SwitchOffEvent());
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
