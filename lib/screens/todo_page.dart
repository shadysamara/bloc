import 'package:bloc_login/bloc/bloc_class.dart';
import 'package:bloc_login/bloc/bloc_states.dart';
import 'package:bloc_login/models/task_model.dart';
import 'package:bloc_login/screens/new_task.dart';
import 'package:bloc_login/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODO PAGE'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return NewTask();
                    },
                  ));
                })
          ],
          bottom: TabBar(tabs: [
            Tab(
              text: 'All Tasks',
            ),
            Tab(
              text: 'Complete Tasks',
            ),
            Tab(
              text: 'InComplete Tasks',
            )
          ]),
        ),
        body: Container(
          child: TabBarView(children: [
            AllTasksPage(),
            CompleteTasksPage(),
            InCompleteTasksPage()
          ]),
        ),
      ),
    );
  }
}

class AllTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<TaskBloc, BlocState>(
        builder: (context, state) {
          if (state is EmptyTasks) {
            return Center(
              child: Text('Empty Tasks'),
            );
          } else if (state is TasksLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllTasksLoaded) {
            List<Task> tasks = state.tasks;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskWidget(tasks[index]);
              },
            );
          } else if (state is ErrorTasks) {
            return Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}

class CompleteTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<TaskBloc, BlocState>(
        builder: (context, state) {
          if (state is EmptyTasks) {
            return Center(
              child: Text('Empty Tasks'),
            );
          } else if (state is TasksLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllTasksLoaded) {
            List<Task> allTasks = state.tasks;
            List<Task> tasks = allTasks
                .where((element) => element.isComplete == true)
                .toList();
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskWidget(tasks[index]);
              },
            );
          } else if (state is ErrorTasks) {
            return Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}

class InCompleteTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<TaskBloc, BlocState>(
        builder: (context, state) {
          if (state is EmptyTasks) {
            return Center(
              child: Text('Empty Tasks'),
            );
          } else if (state is TasksLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllTasksLoaded) {
            List<Task> allTasks = state.tasks;
            List<Task> tasks = allTasks
                .where((element) => element.isComplete == false)
                .toList();
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskWidget(tasks[index]);
              },
            );
          } else if (state is ErrorTasks) {
            return Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
