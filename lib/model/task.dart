class Task {
  String title;
  bool isComplete;

  Task({required this.title, this.isComplete = false});

  // Convert Task object to a map (for storing in SharedPreferences)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isComplete': isComplete,
    };
  }

  // Convert map to Task object (for loading from SharedPreferences)
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isComplete: json['isComplete'],
    );
  }
}
