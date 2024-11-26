import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/widgets/bottom_widget.dart';
import 'package:nfc_petro/core/widgets/petro_app_bar.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/features/control%20room/controller/control_room_controller.dart';
import 'package:nfc_petro/features/control%20room/view/widget/log_list_item.dart';
import 'package:nfc_petro/features/home/view/widgets/app_drawer.dart';

class ControlRoomPage extends StatelessWidget {
  ControlRoomPage({super.key});
  final ControlRoomController _controlRoomController =
      Get.put(ControlRoomController());
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    _controlRoomController.getAllLogSheet();
    return GetBuilder<ControlRoomController>(
        init: ControlRoomController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              drawer: const AppDrawer(),
              key: scaffoldKey,
              appBar: _controlRoomController.isSearching
                  ? null
                  : PetroAppBar(
                      title: PetroString.controlRoom,
                      onPressed: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                    ),
              body: Column(
                children: [
                  Padding(
                    padding: PetroPadding.v10H24,
                    child: TextField(
                      controller: _textEditingController,
                      enableSuggestions: false,
                      onChanged: (v) => _controlRoomController
                          .search(_textEditingController.text),
                      decoration: const InputDecoration(
                        labelText: PetroString.pleaseEnterValue,
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: isEmpty()
                        ? const PetroText(
                            PetroString.nothingFound,
                            fontWeight: FontWeight.bold,
                          )
                        : ListView.separated(
                            padding: PetroPadding.v10H24,
                            itemCount: _controlRoomController.isSearching
                                ? _controlRoomController.logSheetSearch.length
                                : _controlRoomController
                                    .logSheet.length, // Example data count
                            itemBuilder: (context, index) {
                              return _controlRoomController.isSearching
                                  ? LogListItem(
                                      logSheetModel: _controlRoomController
                                          .logSheetSearch[index],
                                    )
                                  : LogListItem(
                                      logSheetModel: _controlRoomController
                                          .logSheet[index],
                                    );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return PetroGap.gap_8;
                            },
                          ),
                  ),
                  if (!_controlRoomController.isSearching) BottomWidget()
                ],
              ),
            ),
          );
        });
  }

  bool isEmpty() {
    if ((_controlRoomController.isSearching &&
            _controlRoomController.logSheetSearch.isEmpty) ||
        (!_controlRoomController.isSearching &&
            _controlRoomController.logSheet.isEmpty)) {
      return true;
    } else {
      return false;
    }
  }
}
