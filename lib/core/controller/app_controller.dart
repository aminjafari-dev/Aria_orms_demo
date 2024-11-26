import 'package:get/get.dart';
import 'package:nfc_petro/features/login/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class AppController extends GetxController {
  late UserModel userInfo;
  late Database db;
  String baseURL = '';
}
