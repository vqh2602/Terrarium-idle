import 'package:terrarium_idle/widgets/base/text/text.dart';

import 'package:flutter/material.dart';

InputDecoration textFieldInputStyle(
    {required String label, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
    //helperText: 'Helper Text',
    //counterText: '0 characters',
    label: SText.bodyMedium(label, color: Colors.grey),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
    ),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  );
}
