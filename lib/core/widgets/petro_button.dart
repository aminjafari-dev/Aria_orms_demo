import 'package:flutter/material.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';

class PetroButton extends StatelessWidget {
  const PetroButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
  });
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? PetroColors.blue,
        // minimumSize: Size(double.infinity, 50), // Button size
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: PetroPadding.v_8,
        child: PetroText(
          text,
          size: 20,
          color: PetroColors.white,
        ),
      ),
    );
  }
}
