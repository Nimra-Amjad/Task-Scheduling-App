import 'package:fpdart/src/either.dart';
import 'package:task_scheduling_app/core/error/exceptions.dart';
import 'package:task_scheduling_app/core/error/failures.dart';
import 'package:task_scheduling_app/core/network/connection_checker.dart';
import 'package:task_scheduling_app/features/todo/data/datasource/task_local_datasource.dart';
import 'package:task_scheduling_app/features/todo/domain/entity/todo.dart';
import 'package:task_scheduling_app/features/todo/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;
  final ConnectionChecker connectionChecker;
  TaskRepositoryImpl(
    this.localDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, List<Todo>>> createTask(
      {required String title,
      required String description,
      required DateTime dateAndTime}) async {
    try {
      if (await (connectionChecker.isConnected)) {
        final task = await localDataSource.createTask(
          title: title,
          description: description,
          dateAndTime: dateAndTime,
        );
        return right(task);
      } else {
        throw const ServerException("Not Connected To Internet");
      }
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> deleteTask({required String id}) async {
    try {
      if (await (connectionChecker.isConnected)) {
        final tasks = await localDataSource.deleteTask(id: id);
        return right(tasks);
      } else {
        throw const ServerException("Not Connected To Internet");
      }
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> editTask(
      {required String id,
      required String newTitle,
      required String newDescription,
      required DateTime newDateTime}) async {
    try {
      if (await (connectionChecker.isConnected)) {
        final tasks = await localDataSource.editTask(
          id: id,
          title: newTitle,
          description: newDescription,
          dateAndTime: newDateTime,
        );
        return right(tasks);
      } else {
        throw const ServerException("Not Connected To Internet");
      }
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getAllTask() async {
    try {
      if (await (connectionChecker.isConnected)) {
        final tasks = await localDataSource.getAllTasks();
        return right(tasks);
      } else {
        throw const ServerException("Not Connected To Internet");
      }
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
