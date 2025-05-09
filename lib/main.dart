import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task_scheduling_app/core/app_utils/app_colors.dart';
import 'package:task_scheduling_app/features/todo/presentation/bloc/task_bloc.dart';
import 'package:task_scheduling_app/features/todo/presentation/view/todo_screen.dart';
import 'package:task_scheduling_app/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<TaskBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Task Scheduler',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryPurple),
          useMaterial3: true,
        ),
        home: const TodoScreen(),
      );
    });
  }
}
