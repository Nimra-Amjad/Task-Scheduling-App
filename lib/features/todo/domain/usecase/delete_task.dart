import 'package:fpdart/fpdart.dart';
import 'package:task_scheduling_app/core/error/failures.dart';
import 'package:task_scheduling_app/core/usecases/usecase.dart';
import 'package:task_scheduling_app/features/todo/domain/entity/todo.dart';
import 'package:task_scheduling_app/features/todo/domain/repository/task_repository.dart';

class DeleteTask implements UseCase<List<Todo>, DeleteTaskParams> {
  final TaskRepository taskRepository;
  const DeleteTask(this.taskRepository);
  @override
  Future<Either<Failure, List<Todo>>> call(DeleteTaskParams params) async {
    return await taskRepository.deleteTask(
      id: params.id,
    );
  }
}

class DeleteTaskParams {
  final String id;

  DeleteTaskParams({
    required this.id,
  });
}
