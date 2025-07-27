import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibm_ai_chat/src/screens/home.dart';
import 'package:ibm_ai_chat/src/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IBM AI Chat',
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      home: const Home(),
    );
  }
}
