import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibm_ai_chat/src/theme/theme.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ChatBox extends StatelessWidget {
  final String content;
  final bool isAi;

  const ChatBox({super.key, required this.content, required this.isAi});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.light;
    final mediaQueryWidth = Get.width;

    return Flexible(
      child: isAi
          ? Container(
              constraints: BoxConstraints(maxWidth: mediaQueryWidth * 0.7),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: appTheme.focusColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: appTheme.primaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),

                        child: Icon(
                          LucideIcons.botMessageSquare,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Text(
                        "IMB Granite AI",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(content),
                ],
              ),
            )
          : Container(
              constraints: BoxConstraints(maxWidth: mediaQueryWidth * 0.7),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: appTheme.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(content, style: TextStyle(color: Colors.white)),
            ),
    );
  }
}
