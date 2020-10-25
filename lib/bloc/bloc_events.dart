import 'package:bloc_login/models/task_model.dart';

abstract class BlocEvent {
  const BlocEvent();
}

class AddTaskEvent extends BlocEvent {
  Task task;
  AddTaskEvent({this.task});
}

class GetAllTasks extends BlocEvent {}

class GetCompletedTasks extends BlocEvent {}

class GetInCompletedTasks extends BlocEvent {}

class DeleteTask extends BlocEvent {
  Task task;
  DeleteTask({this.task});
}

class UpdateTask extends BlocEvent {
  Task task;
  UpdateTask({this.task});
}

class GetOneTaskEvent extends BlocEvent {
  String name;
  GetOneTaskEvent({this.name});
}
