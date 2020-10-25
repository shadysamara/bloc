import 'package:bloc/bloc.dart';
import 'package:bloc_login/bloc/bloc_events.dart';
import 'package:bloc_login/bloc/bloc_states.dart';
import 'package:bloc_login/models/task_model.dart';
import 'package:bloc_login/services/database_helper.dart';
import 'package:flutter/cupertino.dart';

class TaskBloc extends Bloc<BlocEvent, BlocState> {
  TaskBloc(BlocState initialState) : super(initialState);
  List<Task> allTasks;
  Future<List<Task>> getAllTasks() async {
    if (allTasks == null) {
      List<Task> tasks = await DBHelper.dbHelper.getAllTasks();
      allTasks = tasks;
      return tasks;
    } else {
      return allTasks;
    }
  }

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is GetAllTasks) {
      yield TasksLoading();

      ///
      List<Task> allTasks = await getAllTasks();
      if (allTasks.isEmpty) {
        yield EmptyTasks();
      } else {
        yield AllTasksLoaded(allTasks);
      }
    } else if (event is AddTaskEvent) {
      yield TasksLoading();
      try {
        await DBHelper.dbHelper.insertNewTask(event.task);
        List<Task> allTasks = await DBHelper.dbHelper.getAllTasks();
        yield AllTasksLoaded(allTasks);
      } on Exception catch (e) {
        yield ErrorTasks('error in inserting new task');
      }
    } else if (event is DeleteTask) {
      yield TasksLoading();
      try {
        await DBHelper.dbHelper.deleteTask(event.task);
        List<Task> allTasks = await DBHelper.dbHelper.getAllTasks();
        yield AllTasksLoaded(allTasks);
      } on Exception catch (e) {
        yield ErrorTasks('error in deleteing  task');
      }
    } else if (event is UpdateTask) {
      yield TasksLoading();
      try {
        await DBHelper.dbHelper.updateTask(event.task);
        List<Task> allTasks = await DBHelper.dbHelper.getAllTasks();
        yield AllTasksLoaded(allTasks);
      } on Exception catch (e) {
        yield ErrorTasks('error in updating  task');
      }
    }
  }
}
