import 'package:flutter/material.dart';
InputDecoration inputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.black),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.blue, width: 2), // Thicker blue border on focus
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 18.0, // Increased padding vertically
    ),
    
  );
}

