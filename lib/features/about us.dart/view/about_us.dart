import 'package:flutter/material.dart';
import 'package:nfc_petro/config/image_path.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/core/widgets/petro_button.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/features/about%20us.dart/config/textstyle.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: PetroPadding.h_75,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.dpshaLogo,
                height: 128,
              ),
              PetroGap.gap_20,
              RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "AriaORMS",
                      style: PetroTextStyles.boldDarkBlue,
                    ),
                    TextSpan(
                      text:
                          " Software is a proprietary product developed by DPSHA Company.\nAll intellectual property rights are reserved.\n\n",
                      style: PetroTextStyles.blue,
                    ),
                    TextSpan(
                      text: "For further details, please visit our website at ",
                      style: PetroTextStyles.blue,
                    ),
                    TextSpan(
                      text: "SholeArya.ir",
                      style: PetroTextStyles.red,
                    ),
                    TextSpan(
                      text:
                          "\n\nShould you require assistance with the software or wish to provide suggestions to enhance its suitability for your requirements, don’t hesitate to contact us at ",
                      style: PetroTextStyles.blue,
                    ),
                    TextSpan(
                      text: "support.arialims.com",
                      style: PetroTextStyles.red,
                    ),
                  ],
                ),
              ),
              Image.asset(
                ImagePath.colleague,
                height: 200,
              ),
              PetroGap.gap_20,
              PetroButton(
                text: "Back",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
