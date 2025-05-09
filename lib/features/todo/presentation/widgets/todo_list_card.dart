import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task_scheduling_app/core/app_utils/app_colors.dart';
import 'package:task_scheduling_app/core/components/customText/custom_text.dart';

class TodoListCard extends StatelessWidget {
  final String title;
  final String description;
  final String dateAndTime;
  const TodoListCard({
    super.key,
    required this.title,
    required this.description,
    required this.dateAndTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryPurple,
            AppColors.secondaryPurple,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.all(16.sp),
      margin: EdgeInsets.symmetric(
        vertical: 12.sp,
        horizontal: 16.sp,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            textColor: AppColors.primaryWhite,
            fontSize: 20.sp,
          ),
          CustomText(
            text: description,
            textColor: AppColors.primaryWhite,
          ),
          SizedBox(
            height: 2.h,
          ),
          CustomText(
            text: dateAndTime,
            textColor: AppColors.primaryWhite,
          ),
        ],
      ),
    );
  }
}
