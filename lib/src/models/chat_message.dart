import 'package:hive/hive.dart';

part 'chat_message.g.dart';

@HiveType(typeId: 0)
class ChatMessage extends HiveObject {
  @HiveField(0)
  final String content;

  @HiveField(1)
  final bool isAi;

  @HiveField(2)
  final DateTime timestamp;

  ChatMessage({
    required this.content,
    required this.isAi,
    required this.timestamp,
  });
}
