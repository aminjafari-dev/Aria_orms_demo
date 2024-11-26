// import 'package:get/get.dart';
// import 'package:nfc_petro/core/controller/app_controller.dart';
// import 'package:nfc_petro/features/log%20sheet/model/log_sheet_model.dart';
// import 'package:sqflite/sqflite.dart';

// // ignore: must_be_immutable
// class ControlRoomController extends GetxController {
//   List<LogSheetModel> logSheet = [];
//   List<LogSheetModel> logSheetSearch = [];

//   bool isSearching = false;
// // Get all logSheet in the database
//   Future<List<LogSheetModel>> getAllLogSheet() async {
//     AppController appController = Get.put(AppController());
//     int categoryId = appController.userInfo.categoryId!;
//     Database db = appController.db;
//     List<Map<String, dynamic>> result = await db.query('LogSheet', where: '''
//       sitelog=0 and 
//       LogSheetID in (Select ObjectID from PermissionDetails Where TypeObject =5 
//       and PermissionCategoryID  = $categoryId)
//     ''');

//     logSheet =
//         List<LogSheetModel>.from(result.map((x) => LogSheetModel.fromJson(x)));
//     update();
//     return logSheet;
//   }

//   search(String text) {
//     if (text.trim().isNotEmpty) {
//       isSearching = true;
//     } else {
//       isSearching = false;
//     }
//     logSheetSearch = logSheet
//         .where(
//           (item) => item.logName!.toLowerCase().contains(text.toLowerCase()),
//         )
//         .toList();
//     update();
//   }
// }
