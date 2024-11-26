import 'package:flutter/material.dart';
import 'package:nfc_petro/features/about%20us.dart/view/about_us.dart';
import 'package:nfc_petro/features/app%20setting/view/app_setting_page.dart';
import 'package:nfc_petro/features/camera/view/camera_page.dart';
import 'package:nfc_petro/features/checklist%20questions/view/checklist_questions_page.dart';
import 'package:nfc_petro/features/cmms%20checklist/view/page/control_room_page.dart';
import 'package:nfc_petro/features/control%20room/view/page/control_room_page.dart';
import 'package:nfc_petro/features/data%20entry/view/data_entry_page.dart';
import 'package:nfc_petro/features/home/view/page/home_page.dart';
import 'package:nfc_petro/features/login/view/page/login_page.dart';
import 'package:nfc_petro/features/media%20details/view/media_details_page.dart';
import 'package:nfc_petro/features/splash/view/splash_page.dart';
import 'package:nfc_petro/features/sync%20order/view/sync_order_page.dart';
import 'package:nfc_petro/features/sync%20with%20server/view/sync_status_page.dart';

class PageRouter {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    PageName.initPage: (context) => const SplashPage(),
    PageName.home: (context) => HomePage(),
    PageName.aboutUs: (context) => const AboutUsPage(),
    PageName.syncOrder: (context) => const SyncOrderPage(),
    PageName.login: (context) => const LoginPage(),
    PageName.controlRoom: (context) => ControlRoomPage(),
    PageName.dataEntry: (context) => const DataEntryPage(),
    PageName.syncStatus: (context) =>  SyncStatusPage(),
    PageName.camera: (context) => CameraPage(),
    PageName.mediaDetails: (context) => MediaDetailsPage(),
    PageName.appSetting: (context) => AppSettingPage(),
    PageName.checklist: (context) => CmmsChecklistPage(),
    PageName.checklistQuestions: (context) => const ChecklistQuestionsPage(),
  };
}

class PageName {
  static const String initPage = "/";
  static const String home = "/home";
  static const String aboutUs = "/about_us";
  static const String login = "/login";
  static const String controlRoom = "/control_room";
  // static const String logSheet = "/log_sheet";
  static const String dataEntry = "/data_entry";
  static const String camera = "/camera";
  static const String mediaDetails = "/media_details";
  static const String syncOrder = "/sync_order";
  static const String syncStatus = "/sync_with_server";
  static const String appSetting = "/app_setting";
  static const String checklist = "/checklist";
  static const String checklistQuestions = "/checklist_questions";
}
