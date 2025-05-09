import 'package:task_scheduling_app/features/todo/domain/entity/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dateTime,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dateTime: DateTime.parse(map['dateTime']),
    );
  }

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dateTime,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  static List<TodoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TodoModel.fromJson(json)).toList();
  }
}
