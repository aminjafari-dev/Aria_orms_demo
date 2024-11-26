import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/features/log%20sheet/controller/log_sheet_controller.dart';
import 'package:nfc_petro/features/log%20sheet/model/log_sheet_model.dart';
import 'package:nfc_petro/features/log%20sheet/view/pages/log_sheet_page.dart';
import 'package:nfc_petro/features/login/model/user_model.dart';
import 'package:nfc_petro/features/nfc%20error/view/tag_error_page.dart';
import 'package:sqflite/sqflite.dart';

class ScanController extends GetxController {
  String? nfcTag;
  bool scanning = false;
  void startNFCReading() async {
    try {
      bool isAvailable = await NfcManager.instance.isAvailable();

      //We first check if NFC is available on the device.
      if (isAvailable) {
        scanning = true;
        //If NFC is available, start an NFC session and listen for NFC tags to be discovered.
        NfcManager.instance.startSession(
          onDiscovered: (NfcTag tag) async {
            // Process NFC tag, When an NFC tag is discovered, print its data to the console.
            final identifier = tag.data['nfca']['identifier'];
            final v = _convertToUniqueId(identifier);
            nfcTag = v;
            goToLogsheetPage(nfcTag!);
            update();
          },
        );
      } else {
        Get.snackbar("NFC", "Please turn on NFC");
        scanning = false;
      }
    } catch (e) {
      scanning = false;
      Get.snackbar("Error", "Error in reading");
    }
    update();
  }

  void nfcStoped() async {
    await NfcManager.instance.stopSession();
    scanning = false;
    update();
  }

  Future<void> goToLogsheetPage(String nfcTag) async {
    AppController appController = Get.put(AppController());
    Database db = appController.db;
    UserModel user = appController.userInfo;
    List<Map<String, dynamic>> result =
        await db.query("RFID", where: '''RFIDTag = '$nfcTag'
         and UnitCategoryId in (Select ObjectId from PermissionDetails 
         Where PermissionCategoryId = ${user.categoryId}
         And TypeObject = 0)
        ''');
    if (result.isNotEmpty) {
      var item = result[0];

      locator<LogSheetController>().logSheetModel = LogSheetModel(
        rfid: nfcTag,
        unitCategoryId: item['UnitCategoryID'],
        logName: item['Location'] ?? 'NFC Tag',
      );
      Get.to(LogSheetPage());
    } else {
      Get.to(
        TagErrorPage(),
      );
    }
  }

  String _convertToUniqueId(List<int> identifier) {
    // Convert the identifier list to a hexadecimal string
    final hexString =
        identifier.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
    // Take the first 8 characters to create a unique 8-character string
    return hexString.substring(0, 8).toUpperCase();
  }
}
