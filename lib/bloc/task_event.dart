abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;
  AddTaskEvent(this.title);
}

class ToggleTaskEvent extends TaskEvent {
  final int index;
  ToggleTaskEvent(this.index);
}
