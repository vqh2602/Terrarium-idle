import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Widget inputAuth({
  String? hintText,
  TextEditingController? controller,
  bool obscureText = false,
  String? Function(String?)? validate,
}) {
  return TextFormField(
      controller: controller,
      validator: validate,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.white, // Set the desired text input color here
      ),
      decoration: InputDecoration(
        hintText: hintText,
        counterStyle: const TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Get.theme.primaryColor),
        enabledBorder:
            const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ));
}

Widget inputCat(
    {String? label,
    TextEditingController? controller,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validate,
    Function()? onTap,
    bool? readOnly,
    List<TextInputFormatter>? inputFormatters}) {
  return TextFormField(
      controller: controller,
      validator: validate,
      obscureText: obscureText,
      textInputAction: TextInputAction.done,
      onTap: onTap,
      readOnly: readOnly ?? false,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Colors.white, // Set the desired text input color here
      ),
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // label: label,
        counterStyle: const TextStyle(color: Colors.white),
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100)),
      ));
}
