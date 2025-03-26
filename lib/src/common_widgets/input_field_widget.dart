import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/font_theme.dart';

class InputFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final double borderRadius;
  final String initialValue;

  const InputFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.borderRadius = 6.0,
    this.initialValue = '',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: controller == null ? initialValue : null,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: inputText,
        labelStyle: inputLabelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF80C4B7)),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE3856B)),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
