import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_tracker_app/features/chat/domain/entities/chat_entity.dart';
import 'package:task_tracker_app/core/theme/app_theme.dart';

class ChatCard extends StatelessWidget {
  final ChatEntity chat;

  const ChatCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          CircleAvatar(radius: 28, backgroundImage: AssetImage(chat.avatar)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.displayName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color:
                        Theme.of(
                          context,
                        ).extension<AppColorsExtension>()!.titleColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  chat.status, // Represents the last message
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        Theme.of(
                          context,
                        ).extension<AppColorsExtension>()!.greyColor,
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/icons/camera_icon.svg',
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}
