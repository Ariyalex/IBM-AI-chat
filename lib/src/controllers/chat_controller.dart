import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/chat_message.dart';
import '../services/replicate_service.dart';

class ChatController extends GetxController {
  final ReplicateService _replicateService = ReplicateService();
  final TextEditingController messageController = TextEditingController();

  // Observable variables
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isTyping = false.obs;
  final RxString errorMessage = ''.obs;

  // Hive box for local storage
  Box<ChatMessage>? _chatBox;

  @override
  void onInit() {
    super.onInit();
    _initializeHiveBox();
    _loadWelcomeMessage();
  }

  @override
  void onClose() {
    messageController.dispose();
    _chatBox?.close();
    super.onClose();
  }

  // Initialize Hive box for chat storage
  Future<void> _initializeHiveBox() async {
    try {
      _chatBox = await Hive.openBox<ChatMessage>('chatMessages');
      _loadMessagesFromStorage();
    } catch (e) {
      print('Error initializing Hive box: $e');
    }
  }

  // Load messages from local storage
  void _loadMessagesFromStorage() {
    if (_chatBox != null && _chatBox!.isNotEmpty) {
      // Filter out empty AI messages
      final filtered = _chatBox!.values
          .where(
            (msg) =>
                !(msg.isAi &&
                    (msg.content.isEmpty || msg.content.trim().isEmpty)),
          )
          .toList();
      messages.assignAll(filtered);
    }
  }

  // Add welcome message
  void _loadWelcomeMessage() {
    if (messages.isEmpty) {
      final welcomeMessage = ChatMessage(
        content: "Hello! I'm IBM Granite AI. How can I help you today?",
        isAi: true,
        timestamp: DateTime.now(),
      );
      _addMessage(welcomeMessage);
    }
  }

  // Add message to list and storage
  void _addMessage(ChatMessage message) {
    messages.add(message);
    // Only save to storage if not an empty AI message
    if (!(message.isAi &&
        (message.content.isEmpty || message.content.trim().isEmpty))) {
      _saveMessageToStorage(message);
    }
  }

  // Save message to local storage
  Future<void> _saveMessageToStorage(ChatMessage message) async {
    try {
      await _chatBox?.add(message);
    } catch (e) {
      print('Error saving message: $e');
    }
  }

  // Send user message and get AI response
  Future<void> sendMessage() async {
    final userMessage = messageController.text.trim();

    if (userMessage.isEmpty) {
      _showError('Please enter a message');
      return;
    }

    // Clear input and error
    messageController.clear();
    errorMessage.value = '';

    // Add user message
    final userChatMessage = ChatMessage(
      content: userMessage,
      isAi: false,
      timestamp: DateTime.now(),
    );
    _addMessage(userChatMessage);

    // Prepare AI message with partial content and loading state
    final aiChatMessage = ChatMessage(
      content: '',
      isAi: true,
      timestamp: DateTime.now(),
      partialContent: '',
      isLoading: true,
    );
    _addMessage(aiChatMessage);

    // Show loading and typing indicators
    isLoading.value = true;
    isTyping.value = true;

    // Index of the AI message in the list
    final aiMsgIndex = messages.length - 1;

    try {
      // Get AI response with streaming/polling updates
      await _replicateService
          .generateRespose(
            userMessage,
            onPartial: (partial) {
              // Update partial content in the AI message
              if (aiMsgIndex >= 0 && aiMsgIndex < messages.length) {
                final updated = messages[aiMsgIndex].copyWith(
                  partialContent: partial,
                  isLoading: true,
                );
                messages[aiMsgIndex] = updated;
              }
            },
          )
          .then((finalContent) {
            // Finalize AI message with full content
            if (aiMsgIndex >= 0 && aiMsgIndex < messages.length) {
              final updated = messages[aiMsgIndex].copyWith(
                content: finalContent,
                partialContent: '',
                isLoading: false,
              );
              messages[aiMsgIndex] = updated;
              _saveMessageToStorage(updated);
              print(updated.content);
            }
          });
    } catch (e) {
      print('Error getting AI response: $e');
      _showError('Failed to get response from AI. Please try again.');

      // Update AI message to error state
      if (aiMsgIndex >= 0 && aiMsgIndex < messages.length) {
        final errorMsg = messages[aiMsgIndex].copyWith(
          content:
              "Sorry, I'm having trouble responding right now. Please try again later.",
          partialContent: '',
          isLoading: false,
        );
        messages[aiMsgIndex] = errorMsg;
        _saveMessageToStorage(errorMsg);
      }
    } finally {
      isLoading.value = false;
      isTyping.value = false;
    }
  }

  // Show error message
  void _showError(String message) {
    errorMessage.value = message;
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withValues(alpha: 0.8),
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );
  }

  // Clear all chat messages
  Future<void> clearChat() async {
    try {
      messages.clear();
      await _chatBox?.clear();
      _loadWelcomeMessage();
      errorMessage.value = '';

      Get.snackbar(
        'Success',
        'Chat cleared successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.8),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      _showError('Failed to clear chat');
    }
  }

  // Check if there are any messages
  bool get hasMessages => messages.isNotEmpty;

  // Get message count
  int get messageCount => messages.length;

  // Check if currently processing
  bool get isProcessing => isLoading.value || isTyping.value;
}
