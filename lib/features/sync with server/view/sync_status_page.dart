import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/config/image_path.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_radius.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/controller/loading_controller.dart';
import 'package:nfc_petro/core/widgets/bottom_widget.dart';
import 'package:nfc_petro/core/widgets/petro_app_bar.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/features/home/view/widgets/app_drawer.dart';
import 'package:nfc_petro/features/sync%20with%20server/controller/sync_status_controller.dart';

class SyncStatusPage extends StatelessWidget {
  SyncStatusPage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      key: scaffoldKey,
      appBar: PetroAppBar(
        title: PetroString.syncStatus,
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(),
          GetBuilder<LoadingController>(
            init: LoadingController(),
            builder: (controller) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PetroText(
                      controller.paginatedText,
                      fontWeight: FontWeight.bold,
                    ),
                    PetroGap.gap_8,
                    LinearProgressIndicator(
                      backgroundColor: PetroColors.red.withOpacity(.5),
                      minHeight: 5,
                      borderRadius: PetroRadius.radus_10,
                      color: PetroColors.blue,
                      value: controller.progressValue,
                    ),
                    PetroGap.gap_12,
                  ],
                ),
              );
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.width * .7,
            decoration: BoxDecoration(
              color: PetroColors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                PetroGap.gap_8,
                const PetroText(
                  PetroString.logCheck,
                  size: 20,
                  fontWeight: FontWeight.bold,
                  color: PetroColors.white,
                ),
                GetBuilder<SyncStatusController>(
                  init: SyncStatusController(),
                  builder: (controller) {
                    return Expanded(
                      child: ListView(
                        children: List<Widget>.from(
                          controller.requestLog.map(
                            (e) => PetroText(
                              e,
                              size: 16,
                              color: PetroColors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          PetroGap.gap_40,
          Image.asset(
            ImagePath.workerBlue, // Ensure your worker image is in this folder
            height: 200,
          ),
        ],
      ),
      bottomSheet: BottomWidget(),
    );
  }
}
