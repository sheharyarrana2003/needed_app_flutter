import 'package:flutter/material.dart';
import 'package:needed_app/variables/colors.dart';

Widget buildTextField(String label, TextEditingController controller,
    IconData icon, String? Function(String?)? validator) {
  return TextFormField(
    controller: controller,
    validator: validator,
    maxLines: null,
    decoration: InputDecoration(
      labelText: "Enter $label",
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: BorderSide(color: blueColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
      prefixIcon: Icon(icon),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
    ),
  );
}
