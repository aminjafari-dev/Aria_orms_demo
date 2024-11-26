import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/model/model.dart';
import 'package:nfc_petro/features/log%20sheet/model/read_out_model.dart';
import 'package:sqflite/sqflite.dart';

class DBSendRequestHandler {
//? Readout section
  Database db = locator<AppController>().db;
  var dateformat = DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US');

  Future<List<ReadOutModel>> getReadouts() async {
    try {
      List<Map<String, dynamic>> result =
          await db.query('ReadOuts', where: "Saved = 0");

      List<ReadOutModel> readOutsList =
          List<ReadOutModel>.from(result.map((x) => ReadOutModel.fromJson(x)));
      return readOutsList;
    } catch (e) {
      return [];
    }
  }

  Future<bool> readoutUpdate(int id) async {
    try {
      await db.rawUpdate('Update ReadOuts set Saved = 1 where ID =  $id');

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearOldReadOutData() async {
    try {
      DateTime dateCondition = DateTime.now().add(const Duration(days: -10));

      await db.rawDelete(
          "Delete from  ReadOuts Where  Saved = 1 and FillTime < '${dateformat.format(dateCondition)}'");

      return true;
    } catch (e) {
      return false;
    }
  }

  //? Photos section

  Future<List<PhotoDTO>> getPhotos() async {
    try {
      List<Map<String, dynamic>> result = await db.query(
        'Photos',
      );
      log(result.toString());
      List<PhotoDTO> readOutsList = List<PhotoDTO>.from(
        result.map(
          (x) => PhotoDTO.fromJson(x),
        ),
      );
      return readOutsList;
    } catch (e) {
      return [];
    }
  }

  Future<bool> clearOldPhoto(int photoId) async {
    try {
      await db.rawDelete("Delete from  Photos Where ID = $photoId");

      return true;
    } catch (e) {
      return false;
    }
  }
}
