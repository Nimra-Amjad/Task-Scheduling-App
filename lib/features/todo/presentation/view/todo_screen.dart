import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task_scheduling_app/core/app_utils/app_colors.dart';
import 'package:task_scheduling_app/core/components/customText/custom_text.dart';
import 'package:task_scheduling_app/core/constants/contants.dart';
import 'package:task_scheduling_app/core/services/gemini_service.dart';
import 'package:task_scheduling_app/features/todo/presentation/bloc/task_bloc.dart';
import 'package:task_scheduling_app/features/todo/presentation/widgets/todo_list_card.dart';
import 'package:task_scheduling_app/core/services/speech_to_text_service.dart'; // 👈 import service

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final SpeechToTextService _speechService = SpeechToTextService();
  final GeminiService _geminiService = GeminiService();

  String _recognizedText = '';
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(GetAllTaskEvent());
    _speechService.init();
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      await _speechService.stopListening(onListeningStop: () {
        setState(() {
          _isListening = false;
        });
      });
    } else {
      await _speechService.startListening(
        onResult: (text) async {
          setState(() {
            _recognizedText = text;
          });

          final geminiResponse = await _geminiService.processCommand(text);

          if (geminiResponse == null) return;

          final intent = geminiResponse['intent'];
          final title = geminiResponse['title'] ?? 'No Title';
          final description = geminiResponse['description'] ?? '';
          final dateTimeStr = geminiResponse['datetime'];
          final parsedDateTime =
              DateTime.tryParse(dateTimeStr ?? '') ?? DateTime.now();

          if (intent == 'create') {
            context.read<TaskBloc>().add(
                  CreateTaskEvent(
                    title: title,
                    description: description,
                    dateAndTime: parsedDateTime,
                  ),
                );
          } else if (intent == 'delete') {
            context.read<TaskBloc>().add(
                  DeleteTaskEvent(id: "TASK_ID_BASED_ON_SEARCH"),
                );
          } else if (intent == 'edit') {
            context.read<TaskBloc>().add(
                  EditTaskEvent(
                    id: "TASK_ID_BASED_ON_SEARCH",
                    title: title,
                    description: description,
                    dateAndTime: parsedDateTime,
                  ),
                );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.only(left: 16.sp),
            child: CustomText(
              text: "Hey Jhon!",
              fontSize: 20.sp,
              textColor: AppColors.primaryWhite,
            ),
          ),

          // 👇 Display recognized text below "Hey Jhon!"
          if (_recognizedText.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 16.sp, top: 1.h),
              child: CustomText(
                text: _recognizedText,
                fontSize: 16.sp,
                textColor: AppColors.primaryWhite.withOpacity(0.6),
              ),
            ),

          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetAllTaskSuccess ||
                    state is CreateTaskSuccess ||
                    state is EditTaskSuccess ||
                    state is DeleteTaskSuccess) {
                  final tasks = state is GetAllTaskSuccess
                      ? state.tasks
                      : state is CreateTaskSuccess
                          ? state.tasks
                          : state is EditTaskSuccess
                              ? state.tasks
                              : (state as DeleteTaskSuccess).tasks;

                  final reversedTasks = tasks.reversed.toList();

                  return reversedTasks.isEmpty
                      ? const Center(
                          child: CustomText(
                            text: "No Task Added",
                            textColor: AppColors.primaryWhite,
                          ),
                        )
                      : ListView.builder(
                          itemCount: reversedTasks.length,
                          itemBuilder: (context, index) {
                            final task = reversedTasks[index];
                            return TodoListCard(
                              title: task.title,
                              description: task.description,
                              dateAndTime: formatDateTime(task.dateTime),
                            );
                          },
                        );
                } else if (state is GetAllTaskFailure) {
                  return Center(child: Text("Error: ${state.message}"));
                }

                return const Center(child: Text("No tasks found."));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleListening,
        child: Icon(_isListening ? Icons.mic : Icons.mic),
      ),
    );
  }
}
