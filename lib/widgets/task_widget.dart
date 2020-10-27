import 'package:bloc_login/bloc/bloc_class.dart';
import 'package:bloc_login/bloc/bloc_events.dart';
import 'package:bloc_login/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskWidget extends StatelessWidget {
  Task task;
  TaskWidget(this.task);
  Color color;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        title: Text(task.taskName),
        trailing: Checkbox(
            value: task.isComplete,
            onChanged: (value) {
              BlocProvider.of<TaskBloc>(context).add(UpdateTask(task: task));
            }),
        leading: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<TaskBloc>(context).add(DeleteTask(task: task));
            }),
      ),
    );
  }
}
