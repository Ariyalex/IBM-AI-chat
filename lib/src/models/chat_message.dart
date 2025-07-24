class ChatMessage {
  final String content;
  final bool isAi;
  final DateTime timestamp;

  ChatMessage({
    required this.content,
    required this.isAi,
    required this.timestamp,
  });
}
