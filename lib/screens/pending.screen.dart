import 'package:flutter/material.dart';
import 'package:flutterprueba/models/task.model.dart';

import '../blocs/bloc.exports.dart';
import '../widgets/task_list.dart';

// ignore: must_be_immutable
class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);

  static const id = 'tasks_screen';
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBlocBloc, TasksBlocState>(
      builder: (context, state) {
        List<TaskModel> tasksList = state.pendingTasks;
        return  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    '${tasksList.length} Pendientes | ${state.completedTasks.length} Completadas',
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
