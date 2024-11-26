import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart';

class CameraFunctionController extends GetxController {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  File? photo;

  late String imagePath;
  Future getAvailableCameras() async {
    cameras = await availableCameras();
    await initCamera();
    return;
  }

  Future disposeCamera() async {
    await cameraController!.dispose();
    log("Camera Disposed");
    return;
  }

  Future<void> initCamera() async {
    cameraController = CameraController(
      cameras.first,
      ResolutionPreset.max,
    );
    await cameraController!.initialize();
    log(cameraController.toString());
    return;
  }

  Future<bool> takePhoto() async {
    try {
      final result = await cameraController!.takePicture();
      photo = File(result.path);
      await savePhoto(result);
      return true;
    } catch (e) {
      log("dev-- error taking photo");
      Get.snackbar("dev-error", "taking photo");
      return false;
    }
  }

  void clearPhoto() async {
    photo = null;
    update();
  }

  void navigateToMediaDetails(BuildContext context) {
    Navigator.pushNamed(context, PageName.mediaDetails);
  }

  Future<bool> savePhoto(XFile xFile) async {
    try {
      // Get the directory where to save the image
      final directory = await getApplicationDocumentsDirectory();
      final String newPath = join(directory.path, '${DateTime.now()}.jpg');

      // Save the image to the specified path
      await File(xFile.path).copy(newPath);
      imagePath = newPath;
      return true;
    } catch (e) {
      log("Dev_error, save photo $e");
      Get.snackbar("dev-error", "saving image");
      return false;
    }
  }
}
