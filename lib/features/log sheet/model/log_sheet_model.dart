import 'dart:convert';
import 'package:equatable/equatable.dart';

List<LogSheetModel> userModelFromJson(String str) => List<LogSheetModel>.from(
    json.decode(str).map((x) => LogSheetModel.fromJson(x)));

String userModelToJson(List<LogSheetModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LogSheetModel extends Equatable {
  final int? logSheetId;
  final int? unitCategoryId;
  final String? logName;
  final String? logNumber;
  final bool? siteLog;
  final String? rfid;

  const LogSheetModel({
    this.logSheetId,
    this.unitCategoryId,
    this.logNumber,
    this.logName,
    this.siteLog,
    this.rfid,
  });

  factory LogSheetModel.fromJson(Map<String, dynamic> json) => LogSheetModel(
        logSheetId: json["LogSheetID"],
        unitCategoryId: json["UnitCategoryID"],
        logName: json["LogName"],
        logNumber: json["LogNo"],
        rfid: json["rfid"],
        siteLog: json["sitelog"] == 1 ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "LogSheetID": logSheetId,
        "UnitCategoryID": unitCategoryId,
        "LogName": logName,
        "LogNo": logNumber,
        "sitelog": siteLog,
        "rfid": rfid,
      };

  @override
  List<Object?> get props => [
        logSheetId,
        unitCategoryId,
        logName,
        logNumber,
        rfid,
        siteLog,
      ];
}
