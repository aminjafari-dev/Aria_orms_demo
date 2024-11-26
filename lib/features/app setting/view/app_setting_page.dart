import 'package:flutter/material.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/widgets/petro_button.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_scafold.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/core/widgets/petro_text_field.dart';
import 'package:nfc_petro/features/app%20setting/controller/app_setting_controller.dart';

class AppSettingPage extends StatelessWidget {
  AppSettingPage({super.key});
  final TextEditingController _textEditingController = TextEditingController();
  final AppSettingController _appSettingController =
      locator<AppSettingController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = _appSettingController.api;
    return SafeArea(
      child: PetroScaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: PetroPadding.all_12,
                decoration: BoxDecoration(
                  color: PetroColors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: PetroText(PetroString.appSetting,
                            size: 20, color: Colors.white),
                      ),
                      PetroGap.gap_20,
                      const PetroText(
                        PetroString.yourApiServer,
                        size: 16,
                        color: Colors.white,
                      ),
                      PetroTextField(
                        hint: PetroString.pleaseEnterUserName,
                        controller: _textEditingController,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "This Fild Can't Be Blank";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              PetroGap.gap_20,
              SizedBox(
                width: double.maxFinite,
                child: PetroButton(
                  text: PetroString.save,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      locator<AppSettingController>()
                          .insertToDB(_textEditingController.text);
                      resetLocatorWithNewBaseURL(_textEditingController.text);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
