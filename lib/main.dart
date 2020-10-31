import 'package:bloc_login/bloc/bloc_class.dart';
import 'package:bloc_login/bloc/bloc_events.dart';
import 'package:bloc_login/bloc/bloc_states.dart';
import 'package:bloc_login/screens/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (BuildContext context) {
        return TaskBloc(EmptyTasks());
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TaskBloc>(context).add(GetAllTasks());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TodoPage();
  }
}
