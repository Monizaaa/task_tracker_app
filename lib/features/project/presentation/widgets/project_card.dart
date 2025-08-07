import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/theme/app_theme.dart';
import 'package:task_tracker_app/features/project/domain/entities/member_entity.dart';
import 'package:task_tracker_app/features/project/domain/entities/project_entity.dart';

class ProjectCard extends StatefulWidget {
  final ProjectEntity project;
  final Color progressColor;

  const ProjectCard({
    super.key,
    required this.project,
    required this.progressColor,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  late final List<MemberEntity> _shuffledMembers;

  @override
  void initState() {
    super.initState();
    _shuffledMembers = List.of(widget.project.members)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.project.name,
                style: TextStyle(
                  color:
                      Theme.of(
                        context,
                      ).extension<AppColorsExtension>()!.titleColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              _buildProgressChip(),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            widget.project.description,
            style: TextStyle(
              color:
                  Theme.of(context).extension<AppColorsExtension>()!.greyColor,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              _buildTeamAvatars(),
              const SizedBox(width: 16),
              Expanded(child: _buildProgressBar()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: widget.progressColor, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${widget.project.statusDone}/${widget.project.tasks}',
        style: TextStyle(
          color: Theme.of(context).extension<AppColorsExtension>()!.titleColor,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }

  Color _getAvatarColor(String name) {
    final colors = [
      Colors.red.shade300,
      Colors.green.shade300,
      Colors.blue.shade300,
      Colors.orange.shade300,
      Colors.purple.shade300,
      Colors.teal.shade300,
      Colors.pink.shade300,
    ];
    return colors[name.hashCode % colors.length];
  }

  Widget _buildTeamAvatars() {
    const int maxAvatars = 4;
    final int totalMembers = _shuffledMembers.length;
    final int displayCount =
        totalMembers > maxAvatars ? maxAvatars : totalMembers;

    if (totalMembers == 0) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      // Correctly calculate width for the displayed overlapping avatars
      width: (20.0 * (displayCount - 1) + 32.0),
      height: 40,
      child: Stack(
        children:
            List.generate(displayCount, (index) {
              // If this is the last avatar to be shown AND there are more members,
              // show the "+N" indicator.
              if (index == maxAvatars - 1 && totalMembers > maxAvatars) {
                final remainingCount = totalMembers - (maxAvatars - 1);
                return Positioned(
                  left: (20.0 * index),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white, // Border
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.grey.shade200,
                      child: Text(
                        '+$remainingCount',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              }

              // Otherwise, show the regular member avatar with image fallback.
              final member = _shuffledMembers[index];
              return Positioned(
                left: (20.0 * index),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white, // This acts as a border
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: _getAvatarColor(member.displayName),
                    backgroundImage: NetworkImage(member.avatar),
                  ),
                ),
              );
            }).reversed.toList(),
      ),
    );
  }

  /// Helper to build the rounded linear progress bar.
  Widget _buildProgressBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: widget.project.statusDone / widget.project.tasks,
        backgroundColor: widget.progressColor.withValues(alpha: 0.2),
        valueColor: AlwaysStoppedAnimation<Color>(widget.progressColor),
        minHeight: 8,
      ),
    );
  }
}
