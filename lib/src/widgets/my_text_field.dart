import 'package:flutter/material.dart';

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
    return Flexible(
      child: SizedBox(
        width: double.infinity,
        child: TextField(
          keyboardType: TextInputType.text,
          controller: textController,
          textInputAction: textInputAction,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
