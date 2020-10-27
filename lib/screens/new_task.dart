import 'package:bloc_login/bloc/bloc_class.dart';
import 'package:bloc_login/bloc/bloc_events.dart';
import 'package:bloc_login/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  GlobalKey<FormState> formKey = GlobalKey();
  String taskName;
  bool isComplete = false;
  saveTaskName(String value) {
    this.taskName = value;
  }

  validateNull(String value) {
    if (value == '') {
      return 'required field';
    }
  }

  saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Task task = Task(taskName, isComplete);
      BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(task: task));
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  onSaved: (value) => saveTaskName(value),
                  validator: (value) => validateNull(value),
                  decoration: InputDecoration(
                      labelText: 'text title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                CheckboxListTile(
                  title: Text('isComplete'),
                  value: isComplete,
                  onChanged: (value) {
                    this.isComplete = value;
                  },
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text('Add Task'),
                    onPressed: () {
                      saveForm();
                    })
              ],
            )),
      ),
    );
  }
}
