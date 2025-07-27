import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ibm_ai_chat/src/controllers/chat_controller.dart';
import 'package:ibm_ai_chat/src/theme/theme.dart';
import 'package:ibm_ai_chat/src/widgets/chat_box.dart';
import 'package:ibm_ai_chat/src/widgets/my_text_field.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final chatController = Get.put(ChatController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Scroll to bottom when messages change
    ever(chatController.messages, (_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = Get.width;
    final mediaQueryHeight = Get.height;
    final appTheme = AppTheme.light;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 12,
          children: [
            SvgPicture.asset("assets/ibm_granite.svg", width: 32, height: 32),
            Text("IBM Granite Chat", style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Get.defaultDialog(
                title: "Hapus semua chat",
                content: const Text("Yakin hapus semua riwayat chat?"),
                cancel: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Tidak"),
                ),
                confirm: FilledButton(
                  onPressed: () async {
                    Get.back();

                    try {
                      await chatController.clearChat();
                      Get.snackbar(
                        'Success',
                        'Chat cleared successfully',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.green.withValues(alpha: 0.8),
                        colorText: Colors.white,
                      );
                      Get.back();
                    } catch (e) {
                      Get.back();
                      Get.snackbar(
                        'Error',
                        'Failed to clear chat: $e',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red.withValues(alpha: 0.8),
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: const Text("Ya"),
                ),
              );
            },
            icon: Icon(LucideIcons.trash2, color: Colors.white),
            tooltip: 'Clear Chat',
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: mediaQueryWidth,
        height: mediaQueryHeight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Obx(() {
                // Always scroll to bottom after build if messages change
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _scrollToBottom(),
                );
                return SizedBox(
                  width: mediaQueryWidth,
                  child: chatController.messages.isNotEmpty
                      ? ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.all(16),
                          itemCount: chatController.messages.length,
                          itemBuilder: (context, index) {
                            final message = chatController.messages[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment: message.isAi
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.end,
                                children: [
                                  ChatBox(
                                    isAi: message.isAi,
                                    content: message.content,
                                    partialContent: message.partialContent,
                                    isLoading: message.isLoading,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text("Start chat with IBM Granite model!"),
                        ),
                );
              }),
            ),
            Container(
              height: 100,
              width: mediaQueryWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xffE5E7EB), width: 1),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 17),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  MyTextField(
                    textController: chatController.messageController,
                    hintText: "Ask anything...",
                  ),
                  Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: chatController.isProcessing
                            ? Colors.grey
                            : appTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: chatController.isProcessing
                            ? null
                            : () async {
                                try {
                                  await chatController.sendMessage();
                                } catch (e) {
                                  Get.snackbar(
                                    'Error',
                                    e.toString(),
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red.withValues(
                                      alpha: 0.8,
                                    ),
                                    colorText: Colors.white,
                                  );
                                }
                              },
                        icon: chatController.isLoading.value
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Icon(LucideIcons.send, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
