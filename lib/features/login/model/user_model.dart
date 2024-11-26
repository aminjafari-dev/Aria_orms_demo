import 'dart:convert';
import 'package:equatable/equatable.dart';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel extends Equatable {
  final int? userId;
  final String? userName;
  final String? password;
  final int? categoryId;
  final String? name;
  final String? family;

  const UserModel({
    this.userId,
    this.userName,
    this.password,
    this.categoryId,
    this.name,
    this.family,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["UserID"],
        userName: json["UserName"],
        password: json["Password"],
        categoryId: json["CategoryID"],
        name: json["Name"],
        family: json["Family"],
      );

  Map<String, dynamic> toJson() => {
        "UserID": userId,
        "UserName": userName,
        "Password": password,
        "CategoryID": categoryId,
        "Name": name,
        "Family": family,
      };

  @override
  List<Object?> get props => [
        userId,
        userName,
        password,
        categoryId,
        name,
        family,
      ];
}
