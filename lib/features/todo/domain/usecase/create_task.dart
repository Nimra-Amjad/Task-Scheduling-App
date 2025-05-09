import 'package:fpdart/fpdart.dart';
import 'package:task_scheduling_app/core/error/failures.dart';
import 'package:task_scheduling_app/core/usecases/usecase.dart';
import 'package:task_scheduling_app/features/todo/domain/entity/todo.dart';
import 'package:task_scheduling_app/features/todo/domain/repository/task_repository.dart';

class CreateTask implements UseCase<List<Todo>, CreateTaskParams> {
  final TaskRepository taskRepository;
  const CreateTask(this.taskRepository);
  @override
  Future<Either<Failure, List<Todo>>> call(CreateTaskParams params) async {
    return await taskRepository.createTask(
      title: params.title,
      description: params.description,
      dateAndTime: params.dateAndTime,
    );
  }
}

class CreateTaskParams {
  final String title;
  final String description;
  final DateTime dateAndTime;

  CreateTaskParams({
    required this.title,
    required this.description,
    required this.dateAndTime,
  });
}
