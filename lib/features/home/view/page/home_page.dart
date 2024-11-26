import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/config/image_path.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/widgets/bottom_widget.dart';
import 'package:nfc_petro/core/widgets/petro_app_bar.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_icon_button.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/features/home/controller/home_controller.dart';
import 'package:nfc_petro/features/home/view/widgets/app_drawer.dart';
import 'package:nfc_petro/features/scan/controller/scan_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController _homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PetroAppBar(
        title: PetroString.home,
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: const AppDrawer(),
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: PetroPadding.h_35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.colleague,
                height: 200,
              ),
              PetroGap.gap_20,
              GetBuilder<ScanController>(builder: (controller) {
                return SizedBox(
                  width: 184,
                  child: PetroIconButton(
                    text: controller.scanning
                        ? PetroString.nfcIsOn
                        : PetroString.nfcIsOff,
                    icon: Icons.nfc_rounded,
                    buttonColor: controller.scanning
                        ? null
                        : PetroColors.red,
                    textSize: 18,
                    onPressed: () {
                      if (controller.scanning) {
                        controller.nfcStoped();
                      } else {
                        controller.startNFCReading();
                      }
                    },
                  ),
                );
              }),
              PetroGap.gap_20,
              SizedBox(
                width: 184,
                child: PetroIconButton(
                  text: PetroString.controlRoom,
                  icon: Icons.settings,
                  onPressed: () {
                    _homeController.navigateToControlRoom(context);
                  },
                ),
              ),
              PetroGap.gap_20,
              SizedBox(
                width: 184,
                child: PetroIconButton(
                  text: PetroString.cmmsChecklist,
                  icon: Icons.settings,
                  onPressed: () {
                    _homeController.navigateToControlRoom(context);
                  },
                ),
              ),
              PetroGap.gap_20,
              SizedBox(
                width: 184,
                child: PetroIconButton(
                  text: PetroString.cameraTools,
                  icon: Icons.camera,
                  onPressed: () {
                    _homeController.navigateToCamera(context);
                  },
                ),
              ),
              PetroGap.gap_20,
              SizedBox(
                width: 184,
                child: PetroIconButton(
                  text: PetroString.synchronize,
                  icon: Icons.sync,
                  onPressed: () {
                    _homeController.navigateToSyncOrder(context);
                  },
                ),
              ),
              PetroGap.gap_40,
              const PetroText(
                PetroString.description,
                size: 16,
                color: PetroColors.darkBlue,
                textAlign: TextAlign.justify,
              ),
              PetroGap.gap_60,
            ],
          ),
        ),
      ),
      bottomSheet: BottomWidget(),
    );
  }
}
