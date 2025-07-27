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

  // Not persisted in Hive, for UI streaming state only
  final String partialContent;
  final bool isLoading;

  ChatMessage({
    required this.content,
    required this.isAi,
    required this.timestamp,
    this.partialContent = '',
    this.isLoading = false,
  });

  ChatMessage copyWith({
    String? content,
    bool? isAi,
    DateTime? timestamp,
    String? partialContent,
    bool? isLoading,
  }) {
    return ChatMessage(
      content: content ?? this.content,
      isAi: isAi ?? this.isAi,
      timestamp: timestamp ?? this.timestamp,
      partialContent: partialContent ?? this.partialContent,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
