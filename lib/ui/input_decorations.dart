import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? perfixIcon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.deepPurple,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        hintText: hintText, //Texto Email fondo
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: perfixIcon != null
            ? Icon(perfixIcon, color: Colors.deepPurple)
            : null);
  }
}
