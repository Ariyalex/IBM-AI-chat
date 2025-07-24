import 'package:flutter/material.dart';
import 'package:ibm_ai_chat/src/theme/theme.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textController;
  final TextInputAction? textInputAction;
  final String hintText;

  const MyTextField({
    super.key,
    required this.textController,
    this.textInputAction,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.light;

    return Flexible(
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: TextField(
          keyboardType: TextInputType.text,
          controller: textController,
          textInputAction: textInputAction,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              // color: AppTheme.defaultTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Color(0xffC5C6CC)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 1.5,
                // color: AppTheme.primaryColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 1,
                // color: AppTheme.errorColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 1.5,
                // color: AppTheme.errorColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Color(0xffC5C6CC)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
