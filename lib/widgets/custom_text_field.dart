// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    required this.onChanged,
    super.key,
    required this.hintText,
  });
  Function(String)? onChanged;
  //String? Function(String?)? onValidate;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(color: Colors.white),
    );
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        hintText: hintText,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        border: outlineInputBorder,
      ),
    );
  }
}
