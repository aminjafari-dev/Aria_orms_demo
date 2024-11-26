import 'dart:io';

import 'package:get/get.dart';
import 'package:nfc_petro/core/controller/loading_controller.dart';
import 'package:nfc_petro/core/data%20base/db_readout_handler.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/model/model.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:nfc_petro/core/service/main_service.dart';
import 'package:nfc_petro/features/log%20sheet/model/read_out_model.dart';

class SyncStatusController extends GetxController {
  List<String> requestLog = ["log", "adslf", "alksdjf"];

  setRequestLog(String value) {
    requestLog.add(value);
    update();
  }

  void resetRequestLog() {
    requestLog.clear();
  }

  Future callGetRequests() async {
    await locator<MainService>().unitCategoryService.getUnitCategories();
    await locator<MainService>().unitService.getUnits();
    await locator<MainService>().equipmentService.getEquipments();
    await locator<MainService>().parameterService.getParameters();
    await locator<MainService>().logSheetsService.getLogSheets(pageSize: 10);
    await locator<MainService>().rfidService.getRFIDs();

    Get.snackbar("Success", "Your Data Get Successfully");

    await Future.delayed(
      const Duration(seconds: 3),
    );

    Get.offAllNamed(PageName.home);
  }

  Future callPostRequest() async {
    await callReadoutRequest();
    await callPhotoRequest();

    Get.snackbar("Success", "Your Data Get Successfully");

    await Future.delayed(
      const Duration(seconds: 3),
    );

    Get.offAllNamed(PageName.home);
  }

  Future callReadoutRequest() async {
    DBSendRequestHandler db = DBSendRequestHandler();
    LoadingController loadingController = Get.put(LoadingController());

    List<ReadOutModel> readOutsList = await db.getReadouts();

    int count = 0;
    for (var item in readOutsList) {
      count++;

      loadingController.setLoadingParameters(
          paginatedRespons: PaginatedResponse(
            currentPage: count,
            totalPages: readOutsList.length,
            pageSize: 1,
            totalCount: 1,
            hasPrevious: false,
            hasNext: readOutsList.length == count,
            action: "Inserting Data",
          ),
          showDialog: false);

      ReadOutDTO readOutDTO = ReadOutDTO(
        value: item.value,
        dataCollectorFillTime: item.dateTime,
        // db.dateformat.format(item.dateTime!),
        fillTime: item.fillTime,
        //  db.dateformat.format(item.fillTime!),
        parameterId: item.parameterId,
        userId: item.userId,
      );
      bool response =
          await locator<MainService>().insertService.postReadOut(readOutDTO);

      if (response) {
        await db.readoutUpdate(item.id!);
      }
    }
    await db.clearOldReadOutData();
    return;
  }

  Future callPhotoRequest() async {
    DBSendRequestHandler db = DBSendRequestHandler();
    LoadingController loadingController = Get.put(LoadingController());

    List<PhotoDTO> photosList = await db.getPhotos();

    int count = 0;
    for (var item in photosList) {
      count++;

      loadingController.setLoadingParameters(
        paginatedRespons: PaginatedResponse(
          currentPage: count,
          totalPages: photosList.length,
          pageSize: 1,
          totalCount: 1,
          hasPrevious: false,
          hasNext: photosList.length == count,
          action: "Inserting Photos",
        ),
        showDialog: false,
      );
      bool isfileExist = await File(item.file!).exists();
      if (isfileExist) {
        File file = File(item.file!);
        bool respons = await locator<MainService>().photoService.uploadPhoto(
              file,
              item.photoId!,
              item.userId!,
              item.takeTime!,
              item.remark!,
              equipmentId: item.equipmentId,
              unitId: item.equipmentId,
            );
        if (respons) {
          db.clearOldPhoto(item.photoId!);
        }
      }
    }
  }
}
