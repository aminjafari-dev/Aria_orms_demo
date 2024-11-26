import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:nfc_petro/features/data%20entry/model/chart_data_mode.dart';
import 'package:nfc_petro/features/log%20sheet/model/log_sheet_model.dart';
import 'package:nfc_petro/features/log%20sheet/model/parameter_model.dart';
import 'package:nfc_petro/features/log%20sheet/model/read_out_model.dart';
import 'package:nfc_petro/features/login/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class LogSheetController extends GetxController {
// VARIABLE
  List<ParameterModel> parametersList = [];
  late LogSheetModel _logSheetModel;

  LogSheetModel get logSheetModel => _logSheetModel;

  set logSheetModel(LogSheetModel value) {
    _logSheetModel = value;
    update();
  }

  DateTime? time;
  late int _indexModelSelected;
  bool _dataEntryPageKeyboardIsOpen = true;
  List<ChartDataModel> chartDataModel = [];
  List<ReadOutModel> history = [];
  double highValueChart = 0;
  double lowValueChart = 0;
  bool _isOutOfRange = false;
  List<String> dropDownOptions = [];
  final TextEditingController textEditingControllerDataEntryPage =
      TextEditingController();

// GETTER
  bool get isOutOfRange => _isOutOfRange;
  int get indexParameterSelectedGetter => _indexModelSelected;
  bool get dataEntryPageKeyboardIsOpen => _dataEntryPageKeyboardIsOpen;

// SETTER
  set isOutOfRange(bool value) {
    _isOutOfRange = value;
    update();
  }

  set dataEntryPageKeyboardIsOpen(bool value) {
    if (value != _dataEntryPageKeyboardIsOpen) {
      update();
    }
    _dataEntryPageKeyboardIsOpen = value;
  }

  Future<void> indexParameterSelectedSetter(int value) async {
    _indexModelSelected = value;
    setTextEditControllerDataEntryPage();
    await showHistory();
    await setDropDownOption();
    update();
  }

// FUNCTIONS

  void setTextEditControllerDataEntryPage() {
    textEditingControllerDataEntryPage.text =
        parametersList[_indexModelSelected].value ?? '';
  }

  // void navigateToDataEntry(BuildContext context) {
  //   if (!context.mounted) return;
  //   Navigator.pushNamed(context, PageName.dataEntry);
  // }

  Future<bool> showHistory() async {
    AppController appController = Get.put(AppController());
    var parameterSelected = parametersList[indexParameterSelectedGetter];
    Database db = appController.db;

    try {
      List<Map<String, dynamic>> result = await db.query(
        "ReadOuts",
        where:
            "IsDeleted = 0 and ParameterId = ${parameterSelected.parameterId}",
        orderBy: "FillTime desc",
        limit: 10,
      );
      chartDataModel = [];
      history = [];
      history = List<ReadOutModel>.from(
        result.map(
          (e) {
            ReadOutModel readOut = ReadOutModel.fromJson(e);
            chartDataModel.add(ChartDataModel(
              chartDataModel.length + 1,
              double.parse(readOut.value!),
            ));
            return readOut;
          },
        ),
      );

      double highValue = 0;
      double lowValue = 0;
      for (var element in chartDataModel) {
        if (highValue < element.y) {
          highValue = element.y;
        }
        if (lowValue > element.y) {
          lowValue = element.y;
        }
      }

      double upperTolerance = (highValue.abs() * .1);
      double lowerTolerance = (lowValue.abs() * .1);
      highValueChart = highValue + upperTolerance;
      lowValueChart = lowValue - lowerTolerance;
      return true;
    } catch (e) {
      return false;
    }
  }

// Get all logSheet in the database
  Future<List<ParameterModel>> getAllParameters(
      LogSheetModel logSheetModel) async {
    if (logSheetModel.rfid != null) {
    } else {}

    AppController appController = Get.put(AppController());
    Database db = appController.db;
    var loghseetId = logSheetModel.logSheetId;
    var formatter = DateFormat("yyyy-MM-dd HH:mm:ss", "en_Us");
    List<Map<String, dynamic>> result;
    List<Map<String, dynamic>> readOutResult;

    await setTime(logSheetModel);
//! RFID == Null
    if (logSheetModel.rfid == null) {
// LOG sheet section
      result = await db.rawQuery('''
Select P.* from Parameters P
Join LogSheetScope ls on P.ParameterID = ls.ParameterId
Where LogSheetId = $loghseetId
Order By ls.OrderNo
      ''');

// REAdout section
      readOutResult = await db.rawQuery('''
Select * from ReadOuts 
where
IsDeleted = 0 and 
  ParameterID in  (Select ParameterId from LogSheetScope where LogsheetId = $loghseetId)
and FillTime = '${formatter.format(time!)}'
      ''');
    } else {
//! RFID != Null
      result = await db.rawQuery('''
Select P.* from Parameters P
Join LogSheetScope ls on P.ParameterID = ls.ParameterId
Where P.RFID = '${logSheetModel.rfid}'
Order By ls.OrderNo
      ''');

// readout section

      readOutResult = await db.rawQuery('''
Select * from ReadOuts 
where
IsDeleted = 0 and 
  ParameterID in  (Select ParameterId from Parameters where RFID = '${logSheetModel.rfid}')
and FillTime = '${formatter.format(time!)}'
      ''');
    }
    parametersList = List<ParameterModel>.from(
      result.map(
        (x) => ParameterModel.fromJson(x),
      ),
    );

// and IsDeleted = 0
    var readouts = List<ReadOutModel>.from(readOutResult.map(
      (x) => ReadOutModel.fromJson(x),
    ));

    for (var r in readouts) {
      for (var p in parametersList) {
        if (p.parameterId == r.parameterId) {
          p.value = r.value.toString();
        }
      }
    }
    update();
    return parametersList;
  }

// Get all logSheet in the database
  Future<bool> setTime(LogSheetModel logSheetModel) async {
    AppController appController = Get.put(AppController());
    Database db = appController.db;
    var loghseetId = logSheetModel.logSheetId;

    if (logSheetModel.rfid != null) {
      List<Map<String, dynamic>> parametersample = await db.rawQuery('''
select LogSheetId from LogSheetScope ls
Join Parameters p on p.ParameterId = ls.ParameterID
where p.RFID = '${logSheetModel.rfid}'
LIMIT 1
''');
      loghseetId = parametersample[0]["LogSheetID"];
    }

    DateTime now = DateTime.now();
    List<Map<String, dynamic>> result = await db.query(
      'LogSheetProgramDetail',
      where: '''
      LPID = $loghseetId
      ''',
      orderBy: "FillTime",
    );

    var resultList = List<DateTime>.from(
      result.map(
        (x) {
          String time = x["FillTime"].toString();
          int hour = int.parse(time.substring(0, 2));
          int minute = int.parse(time.substring(3));
          return DateTime.now()
              .copyWith(hour: hour, minute: minute, second: 00);
        },
      ),
    );
    int index = resultList.indexWhere((item) => now.compareTo(item) == -1);
    if (index == 0) {
      // We have to change date to one day before
      index = resultList.length;
      time = resultList[index - 1].add(const Duration(days: -1));
    } else if (index == -1) {
      time = resultList.last;
    } else {
      time = resultList[index - 1];
    }
    return true;
  }

  void changeValue(String value) {
    parametersList[indexParameterSelectedGetter].value = value;
    saveDatabase(value);
  }

  Future<void> saveDatabase(String value) async {
    //parametersList[indexModelSelected].value = value;
    DateTime now = DateTime.now();
    AppController appController = Get.put(AppController());
    UserModel user = appController.userInfo;
    ParameterModel activeParameter =
        parametersList[indexParameterSelectedGetter];
    Database db = appController.db;
    var dateformat = DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US');
    List<Map<String, dynamic>> result = await db.query("ReadOuts",
        where:
            "FillTime = '${dateformat.format(time!)}' and ParameterID = ${activeParameter.parameterId} and IsDeleted = 0",
        orderBy: "S_DateTime desc");

    bool newvalue = true;
    if (result.isNotEmpty) {
      ReadOutModel orldRecord = ReadOutModel.fromJson(result[0]);
      newvalue = value != orldRecord.value;

      db.rawUpdate(
          "Update ReadOuts Set IsDeleted = 1 Where ID = ${orldRecord.id}",);

      log("Update ReadOuts ");
    }
       await db.rawInsert(
          '''Insert Into ReadOuts (ParameterId,Value,S_DateTime,FillTime,IsDeleted,UserID,Saved) Values (
    ${activeParameter.parameterId},
    '$value',
    '${dateformat.format(now)}',
    '${dateformat.format(time!)}',
    0,
    ${user.userId},
    0
    )''');
      log("Insert Into ReadOuts");
  }

  // Future<void> insertTest() async {
  //   AppController appController = Get.put(AppController());
  //   var db = await appController.db;
  //   for (int i = 0; i < 5; i++) {
  //     int id = await db.insert(
  //       "ReadOuts",
  //       {
  //         "ParameterID": 123,
  //         "Value": 10 + i, // Example: Increment value by 1 for each record
  //         "S_DateTime": DateTime.now().toString(), // Current date and time
  //         "FillTime": DateTime.now()
  //             .add(Duration(hours: i))
  //             .toString(), // Different FillTime for each record
  //         "IsDeleted": 0,
  //         "UserID": 18,
  //         "Saved": 0,
  //       },
  //     );
  //     log('Inserted record ID: $id');
  //   }
  // }

  Future<bool> setDropDownOption() async {
    try {
      if (parametersList[indexParameterSelectedGetter]
              .entryStyle!
              .toLowerCase() ==
          "select") {
        int parameterId =
            parametersList[indexParameterSelectedGetter].parameterId!;

        AppController appController = Get.put(AppController());
        var db = appController.db;

        List<Map<String, dynamic>> result = await db.query(
          'ParameterOptions',
          where: '''
      ParameterID = $parameterId
      ''',
          orderBy: "OrderNo",
        );

        dropDownOptions = List<String>.from(
          result.map((x) => x['OptionText'].toString()),
        );
        log(dropDownOptions.toString());
      }
      return true;
    } catch (e) {
      log("Set dropdown option Error");
      Get.snackbar("Dev-Error", "Set DropDown option");
      return false;
    }
  }
}
