import 'package:flutter/material.dart';

import '../blocs/bloc.exports.dart';
import '../widgets/task_list.dart';
import 'drawer.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});

  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBlocBloc, TasksBlocState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Historial'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            )
          ],
        ),
        drawer: const MyDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  '${state.removedTasks.length} Tasks',
                ),
              ),
            ),
            TasksList(tasksList: state.removedTasks)
          ],
        ),
      );
    });
  }
}
