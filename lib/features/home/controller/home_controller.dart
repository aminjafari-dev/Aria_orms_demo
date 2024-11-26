import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:nfc_petro/features/camera/controller/camera_controller.dart';

class HomeController {
  void navigateToControlRoom(BuildContext context) {
    Navigator.pushNamed(context, PageName.controlRoom);
  }

  void navigateToCamera(BuildContext context) async {
    final CameraFunctionController cameraFunctionController =
        Get.put(CameraFunctionController());
    await availableCameras();
   await cameraFunctionController.getAvailableCameras();

    Navigator.pushNamed(context, PageName.camera);
  }

  void navigateToSyncOrder(BuildContext context) {
    Navigator.pushNamed(context, PageName.syncOrder);
  }
}
