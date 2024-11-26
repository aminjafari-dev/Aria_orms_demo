import 'package:equatable/equatable.dart';

class AppSettingModel extends Equatable {
  final int id;
  final String api;

  const AppSettingModel({required this.api, required this.id});

  factory AppSettingModel.fromJson(Map<String, dynamic> json) =>
      AppSettingModel(
        id: json['ID'],
        api: json['ApiBaseURL'],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "ApiBaseURL": api,
      };
  @override
  List<Object?> get props => [id, api];
}
