import 'package:fpdart/fpdart.dart';
import 'package:task_scheduling_app/core/error/failures.dart';
import 'package:task_scheduling_app/core/usecases/usecase.dart';
import 'package:task_scheduling_app/features/todo/domain/entity/todo.dart';
import 'package:task_scheduling_app/features/todo/domain/repository/task_repository.dart';

class EditTask implements UseCase<List<Todo>, EditTaskParams> {
  final TaskRepository taskRepository;
  const EditTask(this.taskRepository);
  @override
  Future<Either<Failure, List<Todo>>> call(EditTaskParams params) async {
    return await taskRepository.editTask(
      id: params.id,
      newTitle: params.title,
      newDescription: params.description,
      newDateTime: params.dateAndTime,
    );
  }
}

class EditTaskParams {
  final String id;
  final String title;
  final String description;
  final DateTime dateAndTime;

  EditTaskParams({
    required this.id,
    required this.title,
    required this.description,
    required this.dateAndTime,
  });
}
