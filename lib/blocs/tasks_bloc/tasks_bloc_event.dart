part of 'tasks_bloc_bloc.dart';

abstract class TasksBlocEvent extends Equatable {
  const TasksBlocEvent();

  @override
  List<Object> get props => [];
}

class UpdateTask extends TasksBlocEvent {
  final TaskModel taskModel;
  const UpdateTask({
    required this.taskModel,
  });

  @override
  List<Object> get props => [taskModel];
}

class DeleteTask extends TasksBlocEvent {
  final TaskModel taskModel;
  const DeleteTask({
    required this.taskModel,
  });

  @override
  List<Object> get props => [taskModel];
}

class AddTask extends TasksBlocEvent {
  final TaskModel taskModel;
  const AddTask({
    required this.taskModel,
  });

  @override
  List<Object> get props => [taskModel];
}

class RemoveTask extends TasksBlocEvent {
  final TaskModel taskModel;
  const RemoveTask({
    required this.taskModel,
  });

  @override
  List<Object> get props => [taskModel];
}

class MarkFavoriteOrUnfavoriteTask extends TasksBlocEvent {
  final TaskModel taskModel;
  const MarkFavoriteOrUnfavoriteTask({
    required this.taskModel,
  });
  @override
  List<Object> get props => [taskModel];
}

class EditTask extends TasksBlocEvent {
  final TaskModel oldTask;
  final TaskModel newTask;
  const EditTask({
    required this.oldTask,
    required this.newTask,
  });

  @override
  List<Object> get props => [
        oldTask,
        newTask,
      ];
}

class RestoreTask extends TasksBlocEvent {
  final TaskModel task;
  const RestoreTask({
    required this.task,
  });

  @override
  List<Object> get props => [
        task,
      ];
}
