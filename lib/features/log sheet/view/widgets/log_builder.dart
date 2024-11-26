import 'package:flutter/material.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/features/log%20sheet/controller/log_sheet_controller.dart';
import 'package:nfc_petro/features/log%20sheet/model/parameter_model.dart';

class LogBuilder extends StatelessWidget {
  LogBuilder({super.key, required this.item, required this.index});
  final ParameterModel item;
  final int index;
  final LogSheetController _logSheetController = locator<LogSheetController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _logSheetController.indexParameterSelectedSetter(index);
        Navigator.pushNamed(context, PageName.dataEntry);
      },
      child: Container(
        color: PetroColors.lightBlue,
        padding: PetroPadding.v_12,
        child: Row(
          children: [
            PetroGap.gap_8,
            Expanded(
              flex: 3,
              child: Center(
                child: PetroText(
                  item.equipmentName ?? '',
                  size: 16,
                  color: PetroColors.darkBlue,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: PetroText(
                  "${item.title} [${item.tag}]",
                  size: 16,
                  color: PetroColors.darkBlue,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: PetroText(
                  item.value ?? '',
                  size: 16,
                  color: PetroColors.darkBlue,
                ),
              ),
            ),
            PetroGap.gap_8,
          ],
        ),
      ),
    );
  }
}
