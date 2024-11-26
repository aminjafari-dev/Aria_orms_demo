import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/core/widgets/bottom_widget.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/core/widgets/petro_button.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/features/home/view/page/home_page.dart';
import 'package:nfc_petro/features/scan/controller/scan_controller.dart';

class TagErrorPage extends StatelessWidget {
  TagErrorPage({
    super.key,
  });
  final AppController _appController = Get.put(AppController());
  final ScanController _scanController = Get.put(ScanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PetroColors.blue,
        
        title: PetroText(
          "User ID: ${_appController.userInfo.userName!}",
          color: PetroColors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: PetroColors.white),
            onPressed: () {
              // Add your menu button logic here
            },
          ),
        ],
      ),
      body: Padding(
        padding: PetroPadding.h_35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning,
              color: PetroColors.red,
              size: 50,
            ),
            PetroGap.gap_20,
            const PetroText(
              "Tag has not been defined",
              size: 20,
              color: PetroColors.red,
            ),
            PetroGap.gap_20,
            Container(
              padding: PetroPadding.all_12,
              decoration: BoxDecoration(
                color: PetroColors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GetBuilder<ScanController>(

                builder: (controller) => PetroText(
                  "Tag Id: ${_scanController.nfcTag}",
                  size: 18,
                  color: PetroColors.white,
                ),
              ),
            ),
            PetroGap.gap_20,
            const PetroText(
              "How to troubleshoot",
              size: 18,
              fontWeight: FontWeight.bold,
              color: PetroColors.blue,
            ),
            PetroGap.gap_12,
            Container(
              padding: PetroPadding.all_12,
              decoration: BoxDecoration(
                color: PetroColors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const PetroText(
                "One of the following issues may have occurred:\n\n"
                "1. The RFID Tag has not been registered in any log sheet.\n"
                "2. You lack the necessary permissions to view the log sheet associated with this tag.\n"
                "3. Your device's database has not been synchronized with the AriaORMS Server.",
                size: 14,
                color: PetroColors.white,
              ),
            ),
            PetroGap.gap_20,
            PetroButton(
              text: "Back",
              onPressed: () {
                // Add your back button logic here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePage(),
                  ),
                );
              },
              backgroundColor: PetroColors.red,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomWidget(),
    );
  }
}
