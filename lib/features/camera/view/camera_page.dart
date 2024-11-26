import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/widgets/petro_app_bar.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/features/camera/controller/camera_controller.dart';
import 'package:nfc_petro/features/home/view/widgets/app_drawer.dart';

class CameraPage extends StatelessWidget {
  CameraPage({super.key});

  final CameraFunctionController _cameraController =
      Get.put(CameraFunctionController());

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, r) {
        _cameraController.disposeCamera();
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: PetroAppBar(
          title: "Camera",
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        drawer: const AppDrawer(),
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: CameraPreview(_cameraController.cameraController!),
            ),
            Positioned(
              bottom: 30,
              left: 1,
              right: 1,
              child: SizedBox(
                width: 90, // Adjust this value to change the size
                height: 90,
                child: FloatingActionButton(
                  onPressed: () async {
                    await _cameraController.takePhoto();
                    // ignore: use_build_context_synchronously
                    _cameraController.navigateToMediaDetails(context);
                  },
                  backgroundColor: PetroColors.blue,
                  shape: const CircleBorder(),
                  child: const PetroText(
                    PetroString.rC,
                    color: PetroColors.white,
                    size: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
