import 'package:bloc_login/models/task_model.dart';

abstract class BlocState {
  const BlocState();
}

class TasksLoading extends BlocState {}

class AllTasksLoaded extends BlocState {
  List<Task> tasks;
  AllTasksLoaded(this.tasks);
}

class CompleteTasksLoaded extends BlocState {
  List<Task> tasks;
  CompleteTasksLoaded(this.tasks);
}

class InCompleteTasksLoaded extends BlocState {
  List<Task> tasks;
  InCompleteTasksLoaded(this.tasks);
}

class EmptyTasks extends BlocState {}

class ErrorTasks extends BlocState {
  String errorMsg;
  ErrorTasks(this.errorMsg);
}

class TaskSelected extends BlocState {
  Task task;
  TaskSelected(this.task);
}
