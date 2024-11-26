import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:nfc_petro/core/service/main_service.dart';
import 'package:nfc_petro/features/login/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class SyncOrderController {
  bool hasConnection = true;
  Future<bool> checkApi() async {
    int count = 0;
    hasConnection = await locator<MainService>().checkAPI.apiCheck();

    return hasConnection;
  }

  void navigateToSyncStatusPage(BuildContext context) {
    Navigator.pushNamed(context, PageName.syncStatus);
  }

  Future<bool> hasUserPermission() async {
    AppController appController = Get.put(AppController());
    Database db = appController.db;
    UserModel user = appController.userInfo;

    List<Map<String, dynamic>> result = await db.query("PermissionCategory",
        where: "CategoryId = ${user.categoryId}");
    log(result.toString());
    // return true;
    if (result.first["GetDataCollectorData"] == 1) {
      return true;
    } else {
      return false;
    }
  }
}
