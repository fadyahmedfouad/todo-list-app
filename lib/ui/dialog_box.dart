import 'package:flutter/material.dart';
import 'my_buttom.dart';


class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onsave;
  final VoidCallback oncancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onsave,
    required this.oncancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[100],
      title: const Text('Add New Task'),
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new task',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(onpressed: onsave, text: 'Save'),
                const SizedBox(width: 8),
                MyButton(onpressed: oncancel, text: 'Cancel'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
