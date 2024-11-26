import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:nfc_petro/features/app%20setting/controller/app_setting_controller.dart';

class SplashController {
  void navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), () {});

    if (!context.mounted) {
      return;
    }

      await locator<AppSettingController>().getFromDB();
      log("-------------------------");
      secondSetupLocator();
    Navigator.pushReplacementNamed(context, PageName.login);
  }
}
