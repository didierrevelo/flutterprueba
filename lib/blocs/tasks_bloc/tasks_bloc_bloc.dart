// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:flutterprueba/blocs/bloc.exports.dart';
import 'package:flutterprueba/models/task.model.dart';

part 'tasks_bloc_event.dart';
part 'tasks_bloc_state.dart';

class TasksBlocBloc extends HydratedBloc<TasksBlocEvent, TasksBlocState> {
  TasksBlocBloc() : super(const TasksBlocState()) {
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    // on<DeleteAllTask>(_onDeleteAllTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksBlocState> emit) {
    final state = this.state;
    emit(TasksBlocState(
      pendingTasks: List.from(state.pendingTasks)..add(event.taskModel),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksBlocState> emit) {
    final state = this.state;
    final task = event.taskModel;
    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> completedTasks = state.completedTasks;

    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: true)),
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false)),
          };
    emit(TasksBlocState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: state.removedTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksBlocState> emit) {
    final state = this.state;
    emit(TasksBlocState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.taskModel)));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksBlocState> emit) {
    final state = this.state;
    emit(TasksBlocState(
      pendingTasks: List.from(state.pendingTasks)..remove(event.taskModel),
      completedTasks: List.from(state.completedTasks)..remove(event.taskModel),
      favoriteTasks: List.from(state.favoriteTasks)..remove(event.taskModel),
      removedTasks: List.from(state.removedTasks)
        ..add(event.taskModel.copyWith(isDelete: true)),
    ));
  }

  @override
  TasksBlocState? fromJson(Map<String, dynamic> json) {
    return TasksBlocState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksBlocState state) {
    return state.toMap();
  }

  void _onMarkFavoriteOrUnfavoriteTask(
      MarkFavoriteOrUnfavoriteTask event, Emitter<TasksBlocState> emit) async {
    final state = this.state;
    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> completedTasks = state.completedTasks;
    List<TaskModel> favoriteTasks = state.favoriteTasks;
    if (event.taskModel.isDone == false) {
      if (event.taskModel.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(event.taskModel);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.taskModel)
          ..insert(taskIndex, event.taskModel.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.taskModel.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.taskModel);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.taskModel)
          ..insert(taskIndex, event.taskModel.copyWith(isFavorite: false));
        favoriteTasks.remove(event.taskModel);
      }
    } else {
      if (event.taskModel.isFavorite == false) {
        var taskIndex = completedTasks.indexOf(event.taskModel);
        completedTasks = List.from(completedTasks)
          ..remove(event.taskModel)
          ..insert(taskIndex, event.taskModel.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.taskModel.copyWith(isFavorite: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.taskModel);
        completedTasks = List.from(completedTasks)
          ..remove(event.taskModel)
          ..insert(taskIndex, event.taskModel.copyWith(isFavorite: false));
        favoriteTasks.remove(event.taskModel);
      }
    }
    emit(TasksBlocState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks));
  }

  void _onEditTask(EditTask event, Emitter<TasksBlocState> emit) async {
    final state = this.state;
    List<TaskModel> favouriteTasks = state.favoriteTasks;
    if (event.oldTask.isFavorite == false) {
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(TasksBlocState(
      pendingTasks: List.from(state.pendingTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask),
      completedTasks: state.completedTasks..remove(event.oldTask),
      favoriteTasks: favouriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksBlocState> emit) {
    final state = this.state;
    emit(
      TasksBlocState(
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)
        ..insert(0, event.task.copyWith(
          isDelete: false,
          isDone: false,
          isFavorite: false,
        )),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }
}
