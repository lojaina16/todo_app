class Task {
  static const String collectionName = "tasks";
  String? id;
  String? title;
  String? description;
  int? dateTime;
  bool? isDone;

  Task({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
    this.id = "",
  });

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "isDone": isDone,
      "dateTime": dateTime
    };
  }

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
            title: data["title"],
            description: data["description"],
            id: data["id"] as String,
            dateTime: data["dateTime"],
            isDone: data["isDone"]);
}
