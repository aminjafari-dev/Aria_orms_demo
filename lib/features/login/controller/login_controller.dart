
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:nfc_petro/features/login/model/user_model.dart';
import 'package:nfc_petro/features/scan/controller/scan_controller.dart';
import 'package:sqflite/sqflite.dart';

// ignore: must_be_immutable
class LoginController extends Equatable {
  Database db = locator<AppController>().db;
  void navigateToHome(BuildContext context) async {
    Navigator.pushNamed(context, PageName.home);
  }

  void navigateTOSyncOrder(BuildContext context) async {
    Navigator.pushNamed(context, PageName.syncOrder);
  }

// Get all users in the database
  Future<bool> isUserValid(String userName, String password) async {
    AppController appController = Get.put(AppController());
    // Query to select the first user
    String newUserName = userName.toLowerCase().trim();
    String newPassword = password.trim();
    // UserName: jamini, Password: 546248,
    List<Map<String, dynamic>> result;
    try {
      result = await db.query('Users',
          where:
              "Lower(UserName)='$newUserName' and Trim(DataCollectorPass)='$newPassword'"
              );
      // "Lower(UserName)='admin' and Trim(DataCollectorPass)='1209442'");
    } catch (e) {
      Get.snackbar("Not Found", "User Not Found");
      return false;
    }
    if (result.isNotEmpty) {
      appController.userInfo = UserModel.fromJson(result[0]);
      final ScanController scanController = Get.put(ScanController());
      scanController.startNFCReading();
      return true;
    } else {
      Get.snackbar(
        "Not Found",
        "User Not Found",
      );
      return false; // If no user is found
    }
  }

  @override
  List<Object?> get props => [
        db,
      ];
}
