import 'dart:convert';
import 'package:equatable/equatable.dart';

List<ReadOutModel> userModelFromJson(String str) => List<ReadOutModel>.from(
    json.decode(str).map((x) => ReadOutModel.fromJson(x)));

String userModelToJson(List<ReadOutModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// ignore: must_be_immutable
class ReadOutModel extends Equatable {
  final int? parameterId;
  final int? id;
  final DateTime? dateTime;
  final DateTime? fillTime;
  final bool? isDeleted;
  final String? value;
  final int? userId;
  final int? saved;

  const ReadOutModel({
    this.parameterId,
    this.id,
    this.value,
    this.dateTime,
    this.fillTime,
    this.isDeleted,
    this.userId,
    this.saved,
  });

  factory ReadOutModel.fromJson(Map<String, dynamic> json) => ReadOutModel(
        parameterId: json["ParameterID"],
        id: json["ID"],
        value: json["Value"],
        dateTime: json["S_DateTime"] == null
            ? null
            : DateTime.parse(json["S_DateTime"]),
        fillTime:
            json["FillTime"] == null ? null : DateTime.parse(json["FillTime"]),
        isDeleted: json["IsDeleted"] == 0 ? false : true,
        userId: json["UserID"],
        saved: json["Saved"],
      );

  Map<String, dynamic> toJson() => {
        "ParameterID": parameterId,
        "ID": id,
        "Value": value,
        "S_DateTime": dateTime?.toIso8601String(),
        "FillTime": fillTime?.toIso8601String(),
        "IsDeleted": isDeleted,
        "UserId": userId,
        "Saved": saved,
      };

  @override
  List<Object?> get props => [
        parameterId,
        id,
        value,
        dateTime,
        fillTime,
        isDeleted,
        userId,
        saved,
      ];
}
