import 'package:flutter/material.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/config/petro_radius.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';

class PetroDropDown extends StatefulWidget {
  const PetroDropDown(
      {super.key,
      required this.items,
      required this.onChanged,
      this.initValue});
  final List<String> items;
  final void Function(String?) onChanged;
  final String? initValue;

  @override
  State<PetroDropDown> createState() => _PetroDropDownState();
}

class _PetroDropDownState extends State<PetroDropDown> {
  List<DropdownMenuItem<String>> newItems = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    newItems.clear(); // Clear the list before adding items
    for (var item in widget.items) {
      newItems.add(
        DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: PetroPadding.h_8,
            child: PetroText(
              item,
              color: PetroColors.white,
            ),
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: PetroColors.blue,
        borderRadius: PetroRadius.radus_10,
      ),
      child: DropdownButton(
        items: newItems,
        isExpanded: true,
        iconSize: 20,
        iconDisabledColor: PetroColors.white,
        iconEnabledColor: PetroColors.white,
        dropdownColor: PetroColors.blue,
        borderRadius: PetroRadius.radus_10,
        hint: const Padding(
          padding: PetroPadding.h_8,
          child: PetroText(
            PetroString.selectAnOption,
            color: PetroColors.white,
          ),
        ),
        onChanged: widget.onChanged,

        value: widget.initValue == null || widget.initValue!.isEmpty
            ? null
            : widget.initValue, // Ensure value is part of the items list
      ),
    );
  }
}
