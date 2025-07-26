import '../models/chat_message.dart';

class DummyData {
  static List<ChatMessage> getChatMessages() {
    return [
      ChatMessage(
        content: "Hello! I'm here to help you. Ask me anything!",
        isAi: true,
        timestamp: DateTime.now().subtract(Duration(minutes: 30)),
      ),
      ChatMessage(
        content: "What's the weather like today?",
        isAi: false,
        timestamp: DateTime.now().subtract(Duration(minutes: 29)),
      ),
      ChatMessage(
        content:
            "I can help you check the weather! However, I don't have access to real-time weather data right now. You can check your local weather app or website for the most accurate information.",
        isAi: true,
        timestamp: DateTime.now().subtract(Duration(minutes: 28)),
      ),
      ChatMessage(
        content: "Can you help me with coding questions?",
        isAi: false,
        timestamp: DateTime.now().subtract(Duration(minutes: 25)),
      ),
      ChatMessage(
        content:
            "Absolutely! I'd be happy to help you with coding questions. Whether it's Flutter, Dart, or any other programming language, feel free to ask me anything!",
        isAi: true,
        timestamp: DateTime.now().subtract(Duration(minutes: 24)),
      ),
      ChatMessage(
        content: "How do I create a ListView in Flutter?",
        isAi: false,
        timestamp: DateTime.now().subtract(Duration(minutes: 20)),
      ),
      ChatMessage(
        content:
            "Great question! To create a ListView in Flutter, you can use ListView.builder() for dynamic lists. Here's a basic example:\n\nListView.builder(\n  itemCount: items.length,\n  itemBuilder: (context, index) {\n    return ListTile(\n      title: Text(items[index]),\n    );\n  },\n)",
        isAi: true,
        timestamp: DateTime.now().subtract(Duration(minutes: 19)),
      ),
      ChatMessage(
        content: "Thank you! That's very helpful.",
        isAi: false,
        timestamp: DateTime.now().subtract(Duration(minutes: 15)),
      ),
      ChatMessage(
        content:
            "You're welcome! Is there anything else you'd like to know about Flutter or programming in general?",
        isAi: true,
        timestamp: DateTime.now().subtract(Duration(minutes: 14)),
      ),
    ];
  }
}
