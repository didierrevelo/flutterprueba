import 'package:flutter/material.dart';
import 'package:flutterprueba/widgets/task_tile.dart';

import '../models/task.model.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.tasksList,
  });

  final List<TaskModel> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
            children: tasksList
                .map((task) => ExpansionPanelRadio(
                      value: task.id,
                      headerBuilder: (context, isOpen) => TaskTile(task: task),
                      body: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: SelectableText.rich(TextSpan(children: [
                            const TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: task.title),
                            const TextSpan(
                              text: '\n\nDescripción:\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: task.description),
                            const TextSpan(
                              text: '\n\nFecha limite:\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: task.date),
                          ])),
                        ),
                      ),
                    ))
                .toList()),
      ),
    );
  }
}

// Expanded(
//       child: ListView.builder(
//           itemCount: tasksList.length,
//           itemBuilder: (context, index) {
//             var task = tasksList[index];
//             return TaskTile(task: task);
//           }),
//     );
