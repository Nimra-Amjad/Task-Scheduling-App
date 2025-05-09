import 'package:fpdart/fpdart.dart';
import 'package:task_scheduling_app/core/error/failures.dart';
import 'package:task_scheduling_app/features/todo/domain/entity/todo.dart';

abstract interface class TaskRepository {
  Future<Either<Failure, List<Todo>>> createTask({
    required String title,
    required String description,
    required DateTime dateAndTime,
  });

  Future<Either<Failure, List<Todo>>> getAllTask();

  Future<Either<Failure, List<Todo>>> editTask({
    required String id,
    required String newTitle,
    required String newDescription,
    required DateTime newDateTime,
  });

  Future<Either<Failure, List<Todo>>> deleteTask({required String id});
}
