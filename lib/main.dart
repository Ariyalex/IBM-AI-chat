import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ibm_ai_chat/src/models/chat_message.dart';
import 'package:ibm_ai_chat/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Hive & register adapter
  await Hive.initFlutter();
  Hive.registerAdapter(ChatMessageAdapter());

  runApp(const MyApp());
}
