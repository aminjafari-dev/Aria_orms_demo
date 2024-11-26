import 'dart:convert';
import 'package:equatable/equatable.dart';

List<ParameterModel> userModelFromJson(String str) => List<ParameterModel>.from(
    json.decode(str).map((x) => ParameterModel.fromJson(x)));

String userModelToJson(List<ParameterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// ignore: must_be_immutable
class ParameterModel extends Equatable {
  final int? parameterId;
  final String? title;
  final String? tag;
  final String? uom;
  final String? dataType;
  final String? entryStyle;
  final double? max;
  final double? min;
  final String? sgin;
  final String? rfId;
  final String? equipmentName;
  String? value;

  ParameterModel({
    this.parameterId,
    this.title,
    this.tag,
    this.uom,
    this.dataType,
    this.entryStyle,
    this.max,
    this.min,
    this.sgin,
    this.rfId,
    this.equipmentName,
    this.value,
  });

  factory ParameterModel.fromJson(Map<String, dynamic> json) => ParameterModel(
        parameterId: json["ParameterID"],
        title: json["Title"],
        tag: json["Tag"],
        uom: json["UnitMesserement"],
        dataType: json["DataType"],
        entryStyle: json["DataEntryStyle"],
        max: json["Upper"],
        min: json["Lower"],
        sgin: json["Sign"],
        rfId: json["RFID"],
        value: json["value"].toString().isEmpty ? null : json["value"],
        equipmentName: json["EquipmentName"],
      );

  Map<String, dynamic> toJson() => {
        "ParameterID": parameterId,
        "Title": title,
        "Tag": tag,
        "UnitMesserement": uom,
        "DataType": dataType,
        "DataEntryStyle": entryStyle,
        "Upper": max,
        "Lower": min,
        "Sign": sgin,
        "RFID": rfId,
        "value": value,
        "EquipmentName": equipmentName,
      };

  @override
  List<Object?> get props => [
        parameterId,
        title,
        tag,
        uom,
        dataType,
        entryStyle,
        max,
        min,
        sgin,
        rfId,
        equipmentName,
      ];
}
