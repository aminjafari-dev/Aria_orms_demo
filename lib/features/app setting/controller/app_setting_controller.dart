import 'dart:developer';

import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/features/app%20setting/model/app_setting_model.dart';
import 'package:sqflite/sqflite.dart';

class AppSettingController {
  final AppController _appController = locator<AppController>();
  late List<AppSettingModel> appSettingModelsList = [];
  late String api;

  Future<List<AppSettingModel>> getFromDB() async {
    Database db = _appController.db;

    var result = await db.query("AppSetting");
    appSettingModelsList = List<AppSettingModel>.from(
        result.map((e) => AppSettingModel.fromJson(e)));
    api = appSettingModelsList.last.api;
    log(api.toString());
    _appController.baseURL = api;
    return appSettingModelsList;
  }

  Future insertToDB(String api) async {
    Database db = _appController.db;

    int id = appSettingModelsList.length + 1;

    var model = AppSettingModel(api: api, id: id);

    db.insert(
      "AppSetting",
      model.toJson(),
    );
    _appController.baseURL = api;
  }
}
