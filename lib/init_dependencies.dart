import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:task_scheduling_app/core/network/connection_checker.dart';
import 'package:task_scheduling_app/features/todo/data/datasource/task_local_datasource.dart';
import 'package:task_scheduling_app/features/todo/data/repository/task_repository_impl.dart';
import 'package:task_scheduling_app/features/todo/domain/repository/task_repository.dart';
import 'package:task_scheduling_app/features/todo/domain/usecase/create_task.dart';
import 'package:task_scheduling_app/features/todo/domain/usecase/delete_task.dart';
import 'package:task_scheduling_app/features/todo/domain/usecase/edit_task.dart';
import 'package:task_scheduling_app/features/todo/domain/usecase/get_all_task.dart';
import 'package:task_scheduling_app/features/todo/presentation/bloc/task_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initTask();

  serviceLocator.registerFactory(() => InternetConnection());

  //core
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initTask() {
  //Datasource
  serviceLocator
    ..registerFactory<TaskLocalDataSource>(() => TaskLocalDataSourceImpl())
    //Repository
    ..registerFactory<TaskRepository>(() => TaskRepositoryImpl(
          serviceLocator(),
          serviceLocator(),
        ))
    //Usecases
    ..registerFactory(() => CreateTask(
          serviceLocator(),
        ))
    ..registerFactory(() => GetAllTask(
          serviceLocator(),
        ))
    ..registerFactory(() => EditTask(
          serviceLocator(),
        ))
    ..registerFactory(() => DeleteTask(
          serviceLocator(),
        ))
    //Bloc
    ..registerLazySingleton(() => TaskBloc(
          createTask: serviceLocator(),
          getAllTask: serviceLocator(),
          editTask: serviceLocator(),
          deleteTask: serviceLocator(),
        ));
}
