import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onpressed;
  final String text;

  const MyButton({
    super.key,
    required this.onpressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      child: Text(text),
    );
  }
}
