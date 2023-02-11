import 'package:flutter/material.dart';
import 'package:localproject/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add new task',
              ),
            ),

            //button for save and cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                MyButton(text: 'save', onPressed: onSave),

                //cancel button
                MyButton(text: 'cancel', onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
