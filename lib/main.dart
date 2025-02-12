import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/bloc/task_bloc.dart';
import 'package:todo_list_app/bloc/task_event.dart';
import 'package:todo_list_app/bloc/task_state.dart';

import 'widgets/TodoListScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TaskBloc(),  // Provide TaskBloc here
        child: TodoListScreen(),
      ),
    );
  }
}