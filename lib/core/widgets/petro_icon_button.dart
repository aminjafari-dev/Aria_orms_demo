import 'package:flutter/material.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/config/petro_radius.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';

class PetroIconButton extends StatelessWidget {
  const PetroIconButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.icon,
      this.textSize,
      this.buttonColor});

  final void Function() onPressed;
  final String text;
  final IconData icon;
  final double? textSize;
  final Color? buttonColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: PetroText(
        text,
        color: PetroColors.white,
        size: textSize ?? 20,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? Colors.blue,
        padding: PetroPadding.all_10,
        // minimumSize: Size(double.infinity, 50), // Button size
        shape: RoundedRectangleBorder(
          borderRadius: PetroRadius.radus_10,
        ),
      ),
    );
  }
}
