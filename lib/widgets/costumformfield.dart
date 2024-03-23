import 'package:flutter/material.dart';

class CustomFormMultiline extends StatelessWidget {
  final String hintText;
  final String labelText;
  final double textSize;
  final bool isTextArea;
  final ValueChanged<String>? onChange;

  const CustomFormMultiline({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.textSize = 14,
    this.isTextArea = false,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: isTextArea ? null : 1,
      minLines: isTextArea ? 3 : 1,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      style: TextStyle(fontSize: textSize),
      onChanged: onChange,
    );
  }
}
