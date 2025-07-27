import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ibm_ai_chat/src/theme/theme.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ChatBox extends StatefulWidget {
  final String content;
  final bool isAi;
  final bool isLoading;
  final String? partialContent;

  const ChatBox({
    super.key,
    required this.content,
    required this.isAi,
    this.isLoading = false,
    this.partialContent,
  });

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  void didUpdateWidget(covariant ChatBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If partialContent or isLoading changes, rebuild
    if (oldWidget.partialContent != widget.partialContent ||
        oldWidget.isLoading != widget.isLoading) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.light;
    final mediaQueryWidth = Get.width;

    final displayContent = widget.isLoading
        ? (widget.partialContent ?? "AI is typing...")
        : widget.content;

    return Flexible(
      child: widget.isAi
          //chat box ai
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
                spacing: 5,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            "IBM Granite AI",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: displayContent),
                          );
                          Get.snackbar(
                            'Copied',
                            'Response copied to clipboard',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.blue.withValues(alpha: 0.8),
                            colorText: Colors.white,
                            duration: Duration(seconds: 2),
                          );
                        },
                        icon: Icon(LucideIcons.copy),
                      ),
                    ],
                  ),
                  widget.isLoading
                      ? SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                displayContent,
                                softWrap: true,
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(width: 8),
                              Center(
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      appTheme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          displayContent,
                          softWrap: true,
                          textAlign: TextAlign.left,
                        ),
                ],
              ),
            )
          //chat box user
          : Container(
              constraints: BoxConstraints(maxWidth: mediaQueryWidth * 0.7),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: appTheme.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                widget.content,
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}
