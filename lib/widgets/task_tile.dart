import 'package:flutter/material.dart';
import 'package:flutterprueba/screens/edit_task.screen.dart';
import 'package:flutterprueba/widgets/pop_up_menu.dart';

import '../blocs/bloc.exports.dart';
import '../models/task.model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final TaskModel task;

  void _removeOrDeleteTasks(BuildContext ctx, TaskModel task) {
    task.isDelete!
        ? ctx.read<TasksBlocBloc>().add(DeleteTask(taskModel: task))
        : ctx.read<TasksBlocBloc>().add(RemoveTask(taskModel: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: EditTaskScreen(oldTask: task)),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false
                    ? const Icon(Icons.favorite_border_outlined)
                    : const Icon(Icons.favorite),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          task.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              decoration: task.isDone!
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          task.date2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDelete == false
                    ? (value) {
                        context
                            .read<TasksBlocBloc>()
                            .add(UpdateTask(taskModel: task));
                      }
                    : null,
              ),
              PopUpMenu(
                taskModel: task,
                cancelOrDeleteCallback: () =>
                    _removeOrDeleteTasks(context, task),
                likeOrDislikeCallback: () => context
                    .read<TasksBlocBloc>()
                    .add(MarkFavoriteOrUnfavoriteTask(taskModel: task)),
                editTaskCallback: () {
                  Navigator.of(context).pop();
                  _editTask(context);
                },
                restoreTaskCallback: () => context.read<TasksBlocBloc>().add(RestoreTask(task: task)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




// ListTile(
//       title: Text(task.title,
//       overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//               decoration: task.isDone! ? TextDecoration.lineThrough : null)),
//       trailing: Checkbox(
//         value: task.isDone,
//         onChanged: task.isDelete == false? (value) {
//           context.read<TasksBlocBloc>().add(UpdateTask(taskModel: task));
//         }: null,
//       ),
//       onLongPress: () =>
//           _removeOrDeleteTasks(context, task),
//     );

