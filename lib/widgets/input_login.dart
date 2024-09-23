import 'package:flutter/material.dart';

class InputLogin extends StatefulWidget {
  const InputLogin(
      {super.key,
      required this.textController,
      required this.labelText,
      required this.isPassword});

  final TextEditingController textController;
  final String labelText;
  final bool isPassword;

  @override
  State<InputLogin> createState() {
    return _InputLogin();
  }
}

class _InputLogin extends State<InputLogin> {
  @override
  void dispose() {
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        label: Text(widget.labelText),
        labelStyle: const TextStyle(color: Colors.white),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
