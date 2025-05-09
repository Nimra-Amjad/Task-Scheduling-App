import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_scheduling_app/core/usecases/usecase.dart';
import 'package:task_scheduling_app/features/todo/domain/entity/todo.dart';
import 'package:task_scheduling_app/features/todo/domain/usecase/create_task.dart';
import 'package:task_scheduling_app/features/todo/domain/usecase/delete_task.dart';
import 'package:task_scheduling_app/features/todo/domain/usecase/edit_task.dart';
import 'package:task_scheduling_app/features/todo/domain/usecase/get_all_task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final CreateTask _createTask;
  final GetAllTask _getAllTask;
  final EditTask _editTask;
  final DeleteTask _deleteTask;
  TaskBloc({
    required CreateTask createTask,
    required GetAllTask getAllTask,
    required EditTask editTask,
    required DeleteTask deleteTask,
  })  : _createTask = createTask,
        _getAllTask = getAllTask,
        _editTask = editTask,
        _deleteTask = deleteTask,
        super(TaskInitial()) {
    on<TaskEvent>(
      (event, emit) => emit(
        TaskLoading(),
      ),
    );
    on<CreateTaskEvent>(_createTaskEvent);
    on<GetAllTaskEvent>(_getAllTaskEvent);
    on<EditTaskEvent>(_editTaskEvent);
    on<DeleteTaskEvent>(_deleteTaskEvent);
  }

  void _createTaskEvent(
    CreateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final res = await _createTask(CreateTaskParams(
      title: event.title,
      description: event.description,
      dateAndTime: event.dateAndTime,
    ));

    res.fold(
      (failure) => emit(CreateTaskFailure(message: failure.message)),
      // (success) => emit(CreateTaskSuccess(tasks: success)),
      (success) => add(GetAllTaskEvent()),
    );
  }

  void _getAllTaskEvent(
    GetAllTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final res = await _getAllTask(NoParams());

    res.fold(
      (failure) => emit(GetAllTaskFailure(message: failure.message)),
      (success) => emit(GetAllTaskSuccess(tasks: success)),
    );
  }

  void _editTaskEvent(
    EditTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final res = await _editTask(EditTaskParams(
      id: event.id,
      title: event.title,
      description: event.description,
      dateAndTime: event.dateAndTime,
    ));

    res.fold(
      (failure) => emit(EditTaskFailure(message: failure.message)),
      (success) => emit(EditTaskSuccess(tasks: success)),
    );
  }

  void _deleteTaskEvent(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final res = await _deleteTask(DeleteTaskParams(
      id: event.id,
    ));

    res.fold(
      (failure) => emit(DeleteTaskFailure(message: failure.message)),
      (success) => emit(DeleteTaskSuccess(tasks: success)),
    );
  }
}
