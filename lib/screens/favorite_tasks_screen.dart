import 'package:flutter/material.dart';
import 'package:flutterprueba/models/task.model.dart';

import '../blocs/bloc.exports.dart';
import '../widgets/task_list.dart';

// ignore: must_be_immutable
class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({Key? key}) : super(key: key);

  static const id = 'tasks_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBlocBloc, TasksBlocState>(
      builder: (context, state) {
        List<TaskModel> tasksList = state.favoriteTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  '${tasksList.length} Tasks',
                ),
              ),
            ),
            TasksList(tasksList: tasksList)
          ],
        );
      },
    );
  }
}
