import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_radius.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/model/model.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/features/sync%20with%20server/controller/sync_status_controller.dart';

class LoadingController extends GetxController {
  String paginatedText = "";
  bool isLoading = false;
  double progressValue = 0;

  void setLoadingParameters({
    required PaginatedResponse paginatedRespons,
    required bool showDialog,
  }) {
    int currentPage = paginatedRespons.currentPage;
    bool hasNext = paginatedRespons.hasNext;
    int totalPages = paginatedRespons.totalPages;
    progressValue = (currentPage / totalPages);

    paginatedText =
        '${(progressValue * 100).round()}% - ${paginatedRespons.action}';

    if (currentPage == 1) {
      isLoading = true;
      if (showDialog) {
        loadingShow();
      }
      if (!showDialog) {
        locator<SyncStatusController>().setRequestLog(paginatedRespons.action);
      }
    }

    if (!paginatedRespons.hasNext) {
      isLoading = false;
      if (showDialog) {
        Get.back();
      }
    }
    update();
  }

  void loadingShow() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: PetroRadius.radus_10,
        ),
        content: PopScope(
          canPop: false,
          child: GetBuilder<LoadingController>(
            builder: (controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PetroText(
                    controller.paginatedText,
                    fontWeight: FontWeight.bold,
                  ),
                  PetroGap.gap_12,
                  LinearProgressIndicator(
                    backgroundColor: PetroColors.red.withOpacity(.5),
                    minHeight: 5,
                    borderRadius: PetroRadius.radus_10,
                    color: PetroColors.blue,
                    value: controller.progressValue,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
