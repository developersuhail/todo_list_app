import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/bloc/task_bloc.dart';
import 'package:todo_list_app/bloc/task_event.dart';
import 'package:todo_list_app/bloc/task_state.dart';

class TodoListScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('To-Do List', style:
          TextStyle(
            color : Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Task',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 2.0, // Border width
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 2.0, // Border width
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final taskTitle = _controller.text;
                if (taskTitle.isNotEmpty) {
                  context.read<TaskBloc>().add(AddTaskEvent(taskTitle));
                  _controller.clear(); // Clear the text field after adding
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0), // Optional: adjust button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text('Add Task'),
            ),
            SizedBox(height: 10),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoaded) {
                  print("Displaying ${state.tasks.length} tasks");
                }

                if (state is TaskLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is TaskLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];
                        return ListTile(
                          title: Text(task.title),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                task.isComplete ? 'Complete' : 'Pending',
                                style: TextStyle(
                                  color: task.isComplete ? Colors.green : Colors.red, // Green for Complete, Red for Pending
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Checkbox(
                                value: task.isComplete,
                                onChanged: (_) {
                                  context.read<TaskBloc>().add(ToggleTaskEvent(index));
                                },
                              ),
                            ],
                          ),
                        );

                      },
                    ),
                  );
                } else {
                  return Center(child: Text("No tasks available"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
