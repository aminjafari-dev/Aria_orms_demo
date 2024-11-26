import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/widgets/bottom_widget.dart';
import 'package:nfc_petro/core/widgets/petro_app_bar.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/features/cmms%20checklist/view/widget/checklist_item.dart';
import 'package:nfc_petro/features/control%20room/controller/control_room_controller.dart';
import 'package:nfc_petro/features/control%20room/view/widget/log_list_item.dart';
import 'package:nfc_petro/features/home/view/widgets/app_drawer.dart';

class CmmsChecklistPage extends StatelessWidget {
  CmmsChecklistPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlRoomController>(
        init: ControlRoomController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              drawer: const AppDrawer(),
              appBar: PetroAppBar(
                title: PetroString.cmmsChecklist,
                onPressed: () {},
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: PetroPadding.v10H24,
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return CheckListItem(
                          text: 'Check List ${index + 1}',
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return PetroGap.gap_8;
                      },
                    ),
                  ),
                  BottomWidget()
                ],
              ),
            ),
          );
        });
  }
}
