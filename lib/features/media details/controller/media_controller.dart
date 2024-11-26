import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/features/camera/controller/camera_controller.dart';
import 'package:nfc_petro/features/media%20details/model/option_model.dart';
import 'package:sqflite/sqflite.dart';

class MediaController extends GetxController {
  List<OptionModel> plantList = [];
  List<OptionModel> unitList = [];
  List<OptionModel> equipmenttList = [];

  OptionModel? plantSelected;
  OptionModel? unitSelected;
  OptionModel? equipmenttSelected;

  Future<bool> getPlantOptions() async {
    try {
      AppController appController = Get.put(AppController());
      Database db = appController.db;
      int categoryId = appController.userInfo.categoryId!;

      List<Map<String, dynamic>> result = await db.rawQuery('''
            Select CategoryID,Category from UnitCategory 
            Where CategoryID in (Select ObjectId from PermissionDetails
            where PermissionCategoryID = $categoryId and TypeObject = 0)
        ''');
      plantList = List<OptionModel>.from(
        result.map(
          (e) => OptionModel(
            id: e["CategoryID"],
            title: e["Category"],
          ),
        ),
      );
      log(plantList.toString());
      update();
      return true;
    } catch (e) {
      log("error in get plant option function");
      Get.snackbar("Error_dev", "error in get plant option function");
      return false;
    }
  }

  Future<bool> getUnitOptions(int plantId) async {
    try {
      AppController appController = Get.put(AppController());
      Database db = appController.db;

      List<Map<String, dynamic>> result = await db.rawQuery('''
            Select UnitID,UnitTag,UnitName from Unit
            where CategoryID = $plantId
        ''');

      unitList = List<OptionModel>.from(
        result.map(
          (e) => OptionModel(
            id: e["UnitID"],
            title: e["UnitTag"],
          ),
        ),
      );
      log(unitList.toString());
      update();
      return true;
    } catch (e) {
      log("error in get Unit option function");
      Get.snackbar("Error_dev", "error in get unit option function");
      return false;
    }
  }

  Future<bool> getEquipmentOptions(int unitId) async {
    try {
      AppController appController = Get.put(AppController());
      Database db = appController.db;

      List<Map<String, dynamic>> result = await db.rawQuery('''
            Select EquipmentId,EquipmentType,EquipmentNo from Equipment
            where unitId = $unitId
        ''');

      equipmenttList = List<OptionModel>.from(
        result.map(
          (e) => OptionModel(
            id: e["EquipmentID"],
            title: e["EquipmentNo"],
          ),
        ),
      );
      log(equipmenttList.toString());
      update();
      return true;
    } catch (e) {
      log("error in get Unit option function");
      Get.snackbar("Error_dev", "error in get unit option function");
      return false;
    }
  }

  Future<bool> insertToPhotoTable(String remark) async {
    try {
      AppController appController = Get.put(AppController());
      CameraFunctionController cameraController =
          Get.put(CameraFunctionController());
      Database db = appController.db;

      DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm:ss", "en_Us");
      String time = formatter.format(DateTime.now());
      int userId = appController.userInfo.userId!;
      String imagePath = cameraController.imagePath;
      await db.rawQuery(
        '''
          Insert Into Photos (TakeTime,UserID,PlantID,UnitID,EquipmentID,Remark,PhotoPath,IsSended)
          Values
          ('$time' 
          ,$userId 
          ,${plantSelected!.id} 
          ,${unitSelected?.id} 
          ,${equipmenttSelected?.id}
          ,'$remark' 
          ,'$imagePath'
          ,0 
          )
      ''',
      );
      return true;
    } catch (e) {
      log("dev error -- inser into the photo table----- $e");
      Get.snackbar("Dev-error", "inserting to the photo table");
      return false;
    }
  }

  
}
