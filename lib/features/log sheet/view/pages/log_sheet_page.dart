import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_extentions.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/widgets/petro_app_bar.dart';
import 'package:nfc_petro/core/widgets/bottom_widget.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/features/home/view/widgets/app_drawer.dart';
import 'package:nfc_petro/features/log%20sheet/controller/log_sheet_controller.dart';
import 'package:nfc_petro/features/log%20sheet/view/widgets/log_builder.dart';

class LogSheetPage extends StatelessWidget {
  LogSheetPage({
    super.key,
  });
  final LogSheetController _logSheetController = locator<LogSheetController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LogSheetController>(
      initState: (state) {
        _logSheetController.getAllParameters(_logSheetController.logSheetModel);
      },
      builder: (context) {
        return Scaffold(
          drawer: const AppDrawer(),
          key: scaffoldKey,
          appBar: PetroAppBar(
            title: _logSheetController.logSheetModel.logName ?? '',
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          body: Padding(
            padding: PetroPadding.all_15,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GetBuilder<LogSheetController>(
                    builder: (controller) {
                      return PetroText(
                        _logSheetController.time == null
                            ? ""
                            : "${_logSheetController.time!.hour}:${_logSheetController.time!.minute}"
                                .showAtLeastTwoCharacters(),
                        size: 16,
                        fontWeight: FontWeight.bold,
                        color: PetroColors.blue,
                      );
                    },
                  ),
                ),
                PetroGap.gap_8,
                Container(
                  color: PetroColors.darkBlue,
                  padding: PetroPadding.v_12,
                  child: const Row(
                    children: [
                      PetroGap.gap_8,
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: PetroText(
                            PetroString.equipment,
                            size: 16,
                            color: PetroColors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: PetroText(
                            PetroString.parameter,
                            size: 16,
                            color: PetroColors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: PetroText(
                            PetroString.value,
                            size: 16,
                            color: PetroColors.white,
                          ),
                        ),
                      ),
                      PetroGap.gap_8,
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PetroColors.darkBlue,
                      ),
                    ),
                    child: GetBuilder<LogSheetController>(
                        // init: LogSheetController(),
                        dispose: (s) => _logSheetController.parametersList = [],
                        builder: (context) {
                          return ListView.separated(
                            itemCount:
                                _logSheetController.parametersList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return LogBuilder(
                                item: _logSheetController.parametersList[index],
                                index: index,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                indent: 0,
                                endIndent: 0,
                                thickness: 2,
                                color: PetroColors.darkBlue,
                                height: 0,
                              );
                            },
                          );
                        }),
                  ),
                ),
                PetroGap.gap_40,
              ],
            ),
          ),
          bottomSheet: BottomWidget(),
        );
      },
    );
  }
}
