import 'package:flutter/material.dart';
import 'package:nfc_petro/config/petro_colors.dart';

class PetroTextStyles {
  static const TextStyle red = TextStyle(
    color: Colors.red,
    fontSize: 16,
  );

  static const TextStyle blue = TextStyle(
    color: PetroColors.darkBlue,
    fontSize: 16,
  );

  static const TextStyle boldDarkBlue = TextStyle(
    color: PetroColors.darkBlue,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
