part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class CreateTaskSuccess extends TaskState {
  final List<Todo> tasks;

  CreateTaskSuccess({required this.tasks});
}

final class CreateTaskFailure extends TaskState {
  final String message;

  CreateTaskFailure({required this.message});
}

final class EditTaskSuccess extends TaskState {
  final List<Todo> tasks;

  EditTaskSuccess({required this.tasks});
}

final class EditTaskFailure extends TaskState {
  final String message;

  EditTaskFailure({required this.message});
}

final class DeleteTaskSuccess extends TaskState {
  final List<Todo> tasks;

  DeleteTaskSuccess({required this.tasks});
}

final class DeleteTaskFailure extends TaskState {
  final String message;

  DeleteTaskFailure({required this.message});
}

final class GetAllTaskSuccess extends TaskState {
  final List<Todo> tasks;

  GetAllTaskSuccess({required this.tasks});
}

final class GetAllTaskFailure extends TaskState {
  final String message;

  GetAllTaskFailure({required this.message});
}
