import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final controller;
  final String? label;
  final bool? validate;
  final String? errorText;
  final String hintText;
  final bool obscureText;
  const LoginTextField(
      {super.key,
      this.label,
      this.validate,
      this.errorText,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade800,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            labelText: label != null ? label : null,
            labelStyle: TextStyle(
              color: Colors.grey[500], // Customize label text color
              fontSize: 16, // Customize label text size
              fontWeight: FontWeight.bold, // Customize label text weight
            ), // Include label if provided
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}
