import 'package:flutter/material.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';

class DropDown extends StatelessWidget {
  const DropDown({super.key, this.value, this.items});
  final String? value;
  final List<String>? items;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      iconEnabledColor: PetroColors.white,
      items: items!.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: PetroText(
            value,
            color: PetroColors.black,
          ),
        );
      }).toList(),

      onChanged: (String? newValue) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: PetroColors.blue,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
