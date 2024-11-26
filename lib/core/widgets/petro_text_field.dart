import 'package:flutter/material.dart';
import 'package:nfc_petro/config/petro_colors.dart';

class PetroTextField extends StatelessWidget {
  const PetroTextField({
    super.key,
    this.controller,
    required this.hint,
    this.autoFocus = false,
    this.textInputType = TextInputType.name,
    this.validator,
    this.fillColor,
    this.focusNode
  });
  final TextEditingController? controller;
  final String hint;
  final bool autoFocus;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autoFocus,
      focusNode: focusNode,
      keyboardType: textInputType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: PetroColors.black.withOpacity(.2)),
        filled: true,
        fillColor: fillColor ?? PetroColors.lightWite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: PetroColors.darkBlue),
        ),
      ),
    );
  }
}
