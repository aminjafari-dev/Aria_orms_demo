import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/config/image_path.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/features/log%20sheet/controller/log_sheet_controller.dart';
import 'package:nfc_petro/features/log%20sheet/model/log_sheet_model.dart';
import 'package:nfc_petro/features/log%20sheet/view/pages/log_sheet_page.dart';

class LogListItem extends StatelessWidget {
  final LogSheetModel logSheetModel;

  const LogListItem({super.key, required this.logSheetModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, PageName.logSheet,arguments:logSheetModel.toJson() );
        locator<LogSheetController>().logSheetModel = logSheetModel;
        Get.to(
          LogSheetPage(),
        );
      },
      child: Container(
        padding: PetroPadding.all_10,
        decoration: BoxDecoration(
          color: PetroColors.lightBlue,
          border: Border.all(color: PetroColors.blue, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(ImagePath.package),
            PetroGap.gap_8,
            Expanded(
              child: PetroText(logSheetModel.logName ?? '',
                  size: 20, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
