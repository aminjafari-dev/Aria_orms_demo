import 'package:flutter/material.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';

class DrawerOption extends StatelessWidget {
  const DrawerOption({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: PetroText(
          title,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          size: 20,
        ),
        onTap: onTap);
  }
}
