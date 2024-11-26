import 'package:flutter/material.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/widgets/petro_button.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_scafold.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PetroScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: PetroButton(
              onPressed: () {},
              text: PetroString.getProgram,
            ),
          ),
          PetroGap.gap_20,
          SizedBox(
            width: double.maxFinite,
            child: PetroButton(
              onPressed: () {},
              text: PetroString.sendData,
            ),
          ),
        ],
      ),
    );
  }
}
