import 'package:flutter/material.dart';
import 'package:nfc_petro/config/image_path.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/data%20base/db_controller.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/widgets/bottom_widget.dart';
import 'package:nfc_petro/core/widgets/petro_app_bar.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/core/widgets/petro_button.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/features/home/view/widgets/app_drawer.dart';
import 'package:nfc_petro/features/sync%20order/controller/sync_order_controller.dart';
import 'package:nfc_petro/features/sync%20with%20server/controller/sync_status_controller.dart';

class SyncOrderPage extends StatefulWidget {
  const SyncOrderPage({super.key});

  @override
  State<SyncOrderPage> createState() => _SyncOrderPageState();
}

class _SyncOrderPageState extends State<SyncOrderPage> {
  final SyncOrderController syncOrderController = SyncOrderController();
  bool showGetButton = false;
  @override
  void initState() {
    super.initState();
    initFunction();
  }

  Future<void> initFunction() async {
    showGetButton = await syncOrderController.hasUserPermission();
    await syncOrderController.checkApi();
    setState(() {});
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      key: scaffoldKey,
      appBar: PetroAppBar(
        title: PetroString.synct,
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      body: Padding(
        padding: PetroPadding.h_35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: PetroPadding.all_12,
              decoration: BoxDecoration(
                color: PetroColors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PetroText(
                    PetroString.synchronize,
                    size: 20,
                    fontWeight: FontWeight.bold,
                    color: PetroColors.white,
                  ),
                  PetroText(
                    PetroString.toSelectTheType,
                    size: 16,
                    color: PetroColors.white,
                  ),
                  PetroGap.gap_20,
                ],
              ),
            ),
            PetroGap.gap_20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: PetroButton(
                    text: PetroString.send,
                    backgroundColor: syncOrderController.hasConnection
                        ? null
                        : PetroColors.blue.withOpacity(.2),
                    onPressed: () async {
                      // Add your send button logic here
                      if (syncOrderController.hasConnection) {
                        locator<SyncStatusController>().resetRequestLog();
                        locator<SyncStatusController>().callPostRequest();
                        syncOrderController.navigateToSyncStatusPage(context);
                      }
                    },
                  ),
                ),
                if (showGetButton) PetroGap.gap_20,
                if (showGetButton)
                  Expanded(
                    child: PetroButton(
                      backgroundColor: syncOrderController.hasConnection
                          ? null
                          : PetroColors.blue.withOpacity(.2),
                      text: PetroString.gett,
                      onPressed: () async {
                        if (syncOrderController.hasConnection) {
                          await locator<DbController>().clearDBData();
                          locator<SyncStatusController>().resetRequestLog();
                          locator<SyncStatusController>().callGetRequests();
                          syncOrderController.navigateToSyncStatusPage(context);
                        }
                      },
                    ),
                  ),
              ],
            ),
            if (!syncOrderController.hasConnection) PetroGap.gap_12,
            if (!syncOrderController.hasConnection)
              const PetroText(
                PetroString.youDontHave,
                fontWeight: FontWeight.bold,
                color: PetroColors.red,
                size: 20,
              ),
            if (!syncOrderController.hasConnection) PetroGap.gap_12,
            if (!syncOrderController.hasConnection)
              PetroButton(
                text: PetroString.tryAgain,
                onPressed: () async {
                  await syncOrderController.checkApi();
                  setState(() {});
                },
              ),
            PetroGap.gap_40,
            Image.asset(
              ImagePath
                  .workerBlack, // Ensure your worker image is in this folder
              height: 200,
            ),
          ],
        ),
      ),
      bottomSheet: BottomWidget(),
    );
  }
}
