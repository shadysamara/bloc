import 'package:bloc_login/services/database_helper.dart';

class Task {
  String taskName;
  int id;
  bool isComplete;
  Task(this.taskName, this.isComplete);
  toggleTask() {
    this.isComplete = !this.isComplete;
  }

  Task.fromMap(Map map) {
    this.id = map[DBHelper.taskIdColumnName];
    this.taskName = map[DBHelper.taskNameColumnName];
    this.isComplete = map[DBHelper.taskIsCompeteColumnName] == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    return {
      DBHelper.taskNameColumnName: this.taskName,
      DBHelper.taskIsCompeteColumnName: this.isComplete ? 1 : 0
    };
  }
}
