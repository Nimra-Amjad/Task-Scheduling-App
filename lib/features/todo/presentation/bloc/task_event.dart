part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

final class CreateTaskEvent extends TaskEvent {
  final String title;
  final String description;
  final DateTime dateAndTime;

  CreateTaskEvent({
    required this.title,
    required this.description,
    required this.dateAndTime,
  });
}

final class GetAllTaskEvent extends TaskEvent {}

final class EditTaskEvent extends TaskEvent {
  final String id;
  final String title;
  final String description;
  final DateTime dateAndTime;

  EditTaskEvent(
      {required this.id,
      required this.title,
      required this.description,
      required this.dateAndTime});
}

final class DeleteTaskEvent extends TaskEvent {
  final String id;

  DeleteTaskEvent({required this.id});
}
