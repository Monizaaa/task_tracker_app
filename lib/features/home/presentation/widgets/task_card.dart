import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_tracker_app/core/theme/app_theme.dart';

class TaskCard extends StatelessWidget {
  final String projectName;
  final String taskName;
  final String timeAgo;
  final double progress; // A value between 0.0 and 1.0
  final Color progressColor;

  const TaskCard({
    super.key,
    required this.projectName,
    required this.taskName,
    required this.timeAgo,
    required this.progress,
    this.progressColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey.shade200, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: Title and Time
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                projectName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color:
                      Theme.of(
                        context,
                      ).extension<AppColorsExtension>()!.greyColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                taskName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      Theme.of(
                        context,
                      ).extension<AppColorsExtension>()!.titleColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                timeAgo,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color:
                      Theme.of(
                        context,
                      ).extension<AppColorsExtension>()!.greyColor,
                ),
              ),
            ],
          ),
          // Right side: Circular Progress Indicator
          CircularPercentIndicator(
            radius: 22.0,
            lineWidth: 3.0,
            percent: progress,
            center: Text(
              "${(progress * 100).toInt()}%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color:
                    Theme.of(
                      context,
                    ).extension<AppColorsExtension>()!.titleColor,
              ),
            ),
            backgroundColor: progressColor.withValues(alpha: 0.2),
            progressColor: progressColor,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }
}
