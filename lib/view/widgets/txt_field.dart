import 'package:flutter/material.dart';

class TxtFormFieldWidget extends StatelessWidget {
  TxtFormFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    required this.focus,
  });
  String label;
  Function validator;
  TextEditingController controller;
  FocusNode focus;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focus,
      validator: (value) {
        return validator(value);
      },
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
      ),
    );
  }
}
