import 'package:flutter/material.dart';

import '../models/task.model.dart';

class PopUpMenu extends StatelessWidget {
  final TaskModel taskModel;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;

  const PopUpMenu({
    Key? key,
    required this.taskModel,
    required this.cancelOrDeleteCallback,
    required this.likeOrDislikeCallback,
    required this.editTaskCallback,
    required this.restoreTaskCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: taskModel.isDelete == false
          ? ((context) => [
                PopupMenuItem(
                  // onTap: editTaskCallback,
                  child: TextButton.icon(
                    onPressed: editTaskCallback,
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar'),
                  ),
                ),
                PopupMenuItem(
                  onTap: likeOrDislikeCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: taskModel.isFavorite == false
                    ? const Icon(Icons.bookmark_add_outlined)
                    : const Icon(Icons.bookmark_remove),
                    label: taskModel.isFavorite == false
                    ? const Text('Agregar marcador')
                    : const Text('Quitar marcador'),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    label: const Text('Borrar'),
                  ),
                ),
              ])
          : (context) => [
                PopupMenuItem(
                    onTap: restoreTaskCallback,
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.restore_from_trash),
                      label: const Text('Restaurar'),
                    ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Borrar definitivamente'),
                  ),
                ),
              ],
    );
  }
}
