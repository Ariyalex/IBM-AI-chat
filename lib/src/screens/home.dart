import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ibm_ai_chat/src/theme/theme.dart';
import 'package:ibm_ai_chat/src/widgets/chat_box.dart';
import 'package:ibm_ai_chat/src/widgets/my_text_field.dart';
import 'package:ibm_ai_chat/src/data/dummy_data.dart';
import 'package:ibm_ai_chat/src/models/chat_message.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = Get.width;
    final mediaQueryHeight = Get.height;
    final appTheme = AppTheme.light;
    final List<ChatMessage> chatMessages = DummyData.getChatMessages();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 12,
          children: [
            SvgPicture.asset("assets/ibm_granite.svg", width: 32, height: 32),
            Text("IBM Granite Chat", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: mediaQueryWidth,
        height: mediaQueryHeight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SizedBox(
                width: mediaQueryWidth,
                child: chatMessages.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: chatMessages.length,
                        itemBuilder: (context, index) {
                          final message = chatMessages[index];
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
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Center(child: Text("Start chat with IBM Granite model!")),
              ),
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
                    textController: TextEditingController(),
                    hintText: "Ask anything...",
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: appTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(LucideIcons.send, color: Colors.white),
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
