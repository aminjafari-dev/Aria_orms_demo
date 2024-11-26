import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:shamsi_date/shamsi_date.dart';

class BottomWidget extends StatelessWidget {
  BottomWidget({super.key});
  
  final AppController _appController = Get.put(AppController());
  final Jalali time = Jalali.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: PetroPadding.v10H14,
      child: Row(
        children: [
          const Icon(
            Icons.account_circle,
            color: PetroColors.white,
          ),
          PetroText(
            " ${_appController.userInfo.name} ${_appController.userInfo.family}",
            color: Colors.white,
            size: 15,
          ),
          const Spacer(),
          PetroText(
            ' ${time.year} | ${time.month} | ${time.day}',
            color: Colors.white,
            size: 15,
          ),
        ],
      ),
    );
  }
}
