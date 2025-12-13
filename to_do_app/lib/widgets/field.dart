import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final FocusNode focus;
  const Field({
    super.key,
    this.hintText = "",
    required this.controller,
    this.onSubmitted,
    required this.focus,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 216, 216, 216),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(3, 3)),
          ],
        ),
        child: TextField(
          focusNode: focus,
          onSubmitted: onSubmitted,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.all(10),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
