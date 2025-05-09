import 'package:fpdart/fpdart.dart';
import 'package:task_scheduling_app/core/error/failures.dart';
import 'package:task_scheduling_app/core/usecases/usecase.dart';
import 'package:task_scheduling_app/features/todo/domain/entity/todo.dart';
import 'package:task_scheduling_app/features/todo/domain/repository/task_repository.dart';

class GetAllTask implements UseCase<List<Todo>, NoParams> {
  final TaskRepository taskRepository;
  const GetAllTask(this.taskRepository);
  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await taskRepository.getAllTask();
  }
}
