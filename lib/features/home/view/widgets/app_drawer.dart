import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/config/image_path.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_consist.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/features/camera/controller/camera_controller.dart';
import 'package:nfc_petro/features/home/view/widgets/drawer_option.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = locator<AppController>();
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Container(
        color: PetroColors.blue,
        child: ListView(
          shrinkWrap: true,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: PetroColors.blue,
              ),
              child: Center(
                child: Image.asset(
                  ImagePath.logo, // Adjust the path to your logo image
                  height: 80,
                ),
              ),
            ),
            DrawerOption(
              title: PetroString.home,
              onTap: () {
                Navigator.pushNamed(context, PageName.home);
              },
            ),
            DrawerOption(
              title: PetroString.controlRoom,
              onTap: () {
                Navigator.pushNamed(context, PageName.controlRoom);
              },
            ),
            DrawerOption(
              title: PetroString.cameraTools,
              onTap: () async {
                final CameraFunctionController cameraFunctionController =
                    Get.put(CameraFunctionController());
                await availableCameras();
                await cameraFunctionController.getAvailableCameras();

                Navigator.pushNamed(context, PageName.camera);
              },
            ),
            DrawerOption(
              title: PetroString.about,
              onTap: () {
                Navigator.pushNamed(context, PageName.aboutUs);
              },
            ),
            const Divider(
              color: PetroColors.white,
              endIndent: 17,
              indent: 17,
              thickness: 2,
            ),
            DrawerOption(
              title: PetroString.logout,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  PageName.login,
                  (r) => false,
                );
              },
            ),
            Row(
              children: [
                PetroGap.gap_12,
                const Icon(
                  Icons.account_circle,
                  color: PetroColors.white,
                ),
                PetroText(
                  " ${appController.userInfo.name} ${appController.userInfo.family}",
                  color: Colors.white,
                  size: 15,
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                ImagePath.worker, // Adjust the path to your worker image
                height: 180,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: PetroText(
                PetroString.version + PetroConsist.appVersion,
                color: Colors.white,
              ),
            ),
            PetroGap.gap_40
          ],
        ),
      ),
    );
  }
}
