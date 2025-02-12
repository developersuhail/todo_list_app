import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/model/Task.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {

    // Load tasks from SharedPreferences when the Bloc is created
    _loadTasksFromSharedPreferences();

    // Handle AddTaskEvent
    on<AddTaskEvent>((event, emit) async {
      if (state is TaskLoaded) {
        final tasks = List<Task>.from((state as TaskLoaded).tasks);
        tasks.add(Task(title: event.title));

        // Save the updated task list to SharedPreferences
        await _saveTasksToSharedPreferences(tasks);

        emit(TaskLoaded(tasks)); // Emit the updated task list
      }
    });

    // Handle ToggleTaskEvent
    on<ToggleTaskEvent>((event, emit) async {
      if (state is TaskLoaded) {
        final tasks = List<Task>.from((state as TaskLoaded).tasks);
        tasks[event.index].isComplete = !tasks[event.index].isComplete;

        // Save the updated task list to SharedPreferences
        await _saveTasksToSharedPreferences(tasks);

        emit(TaskLoaded(tasks)); // Emit the updated task list
      }
    });
  }

  // Function to load tasks from SharedPreferences
  Future<void> _loadTasksFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final taskListString = prefs.getString('taskList');

    if (taskListString != null) {
      final List<dynamic> jsonList = json.decode(taskListString);
      final tasks = jsonList.map((json) => Task.fromJson(json)).toList();
      emit(TaskLoaded(tasks)); // Emit the loaded tasks as the state
    } else {
      emit(TaskLoaded([])); // If no tasks are saved, emit an empty list
    }
  }

  // Function to save tasks to SharedPreferences
  Future<void> _saveTasksToSharedPreferences(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskListJson = json.encode(tasks.map((task) => task.toJson()).toList());
    prefs.setString('taskList', taskListJson);
  }
}
