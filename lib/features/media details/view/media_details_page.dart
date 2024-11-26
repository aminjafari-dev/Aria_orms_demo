import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:nfc_petro/core/widgets/petro_app_bar.dart';
import 'package:nfc_petro/core/widgets/bottom_widget.dart';
import 'package:nfc_petro/core/widgets/petro_drop_down.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/core/widgets/petro_button.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_text_field.dart';
import 'package:nfc_petro/features/camera/controller/camera_controller.dart';
import 'package:nfc_petro/features/home/view/widgets/app_drawer.dart';
import 'package:nfc_petro/features/media%20details/controller/media_controller.dart';

class MediaDetailsPage extends StatelessWidget {
  MediaDetailsPage({super.key});
  final CameraFunctionController _cameraFunctionController =
      Get.put(CameraFunctionController());

  final MediaController _mediaController = Get.put(MediaController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    _mediaController.getPlantOptions();
    return Scaffold(
      drawer: const AppDrawer(),
      key: scaffoldKey,
      appBar: PetroAppBar(
        title: "Media Details",
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      body: Padding(
        padding: PetroPadding.h_35,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PetroGap.gap_30,
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PetroColors.lightBlue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: PetroColors.blue, width: 2),
                ),
                child: Center(
                  child: Image.file(_cameraFunctionController.photo!),
                ),
              ),
              PetroGap.gap_20,
              const PetroText(PetroString.remarks,
                  size: 16, color: PetroColors.blue),
              Form(
                key: _formKey,
                child: PetroTextField(
                  hint: "Remark",
                  controller: _textEditingController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Value cannot be blank";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              PetroGap.gap_20,
              const PetroText("Plant", size: 16, color: PetroColors.blue),
              GetBuilder<MediaController>(
                  init: MediaController(),
                  builder: (controller) {
                    List<String> items =
                        controller.plantList.map((e) => e.title!).toList();
                    return PetroDropDown(
                      items: items,
                      initValue: controller.plantSelected?.title,
                      onChanged: (v) {
                        controller.plantSelected = controller.plantList
                            .firstWhere((item) => item.title == v);
                        controller.unitList = [];
                        controller.unitSelected = null;
                        controller
                            .getUnitOptions(controller.plantSelected!.id!);
                      },
                    );
                  }),
              PetroGap.gap_20,
              const PetroText(PetroString.unit,
                  size: 16, color: PetroColors.blue),
              GetBuilder<MediaController>(
                init: MediaController(),
                builder: (controller) {
                  return PetroDropDown(
                    items: controller.unitList.map((e) => e.title!).toList(),
                    initValue: controller.unitSelected?.title,
                    onChanged: (v) {
                      controller.unitSelected = controller.unitList
                          .firstWhere((item) => item.title == v);
                      controller.equipmenttList = [];
                      controller.equipmenttSelected = null;
                      controller
                          .getEquipmentOptions(controller.unitSelected!.id!);
                    },
                  );
                },
              ),
              PetroGap.gap_20,
              const PetroText(PetroString.equipment,
                  size: 16, color: PetroColors.blue),
              GetBuilder<MediaController>(
                init: MediaController(),
                builder: (controller) {
                  return PetroDropDown(
                    items:
                        controller.equipmenttList.map((e) => e.title!).toList(),
                    initValue: controller.equipmenttSelected?.title,
                    onChanged: (v) {
                      controller.equipmenttSelected = controller.equipmenttList
                          .firstWhere((item) => item.title == v);
                      controller.update();
                    },
                  );
                },
              ),
              PetroGap.gap_40,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: PetroButton(
                      text: PetroString.back,
                      onPressed: () {
                        _cameraFunctionController.disposeCamera();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  PetroGap.gap_20,
                  Expanded(
                    child: PetroButton(
                      text: PetroString.save,
                      onPressed: () async {
                        // Add your save button logic here
                        if ((_mediaController.plantSelected == null)) {
                          Get.snackbar("Error", "Plant Item can't be null");
                        } else {
                          _cameraFunctionController.disposeCamera();
                          bool insertValid = await _mediaController
                              .insertToPhotoTable(_textEditingController.text);

                          if (insertValid) {
                            await Navigator.pushReplacementNamed(
                              context,
                              PageName.home,
                            );
                            Get.snackbar(
                              "Success",
                              "Your Image Successfully insert",
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
              PetroGap.gap_40,
              PetroGap.gap_20,
            ],
          ),
        ),
      ),
      bottomSheet: BottomWidget(),
    );
  }
}
