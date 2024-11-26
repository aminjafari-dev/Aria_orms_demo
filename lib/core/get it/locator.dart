import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/core/controller/loading_controller.dart';
import 'package:nfc_petro/core/data%20base/db_controller.dart';
import 'package:nfc_petro/core/service/main_service.dart';
import 'package:nfc_petro/features/app%20setting/controller/app_setting_controller.dart';
import 'package:nfc_petro/features/log%20sheet/controller/log_sheet_controller.dart';
import 'package:nfc_petro/features/scan/controller/scan_controller.dart';
import 'package:nfc_petro/features/sync%20with%20server/controller/sync_status_controller.dart';

// Create a GetIt instance
final GetIt locator = GetIt.instance;

// Method to set up the services
void setupLocator() {
  // Register the LogSheetController as a singleton
  locator.registerLazySingleton<LogSheetController>(
      () => Get.put(LogSheetController()));
  locator.registerSingleton<AppController>(Get.put(AppController()));
  locator.registerSingleton<ScanController>(Get.put(ScanController()));
  locator.registerLazySingleton<LoadingController>(
      () => Get.put(LoadingController()));
  locator.registerLazySingleton<SyncStatusController>(
    () => Get.put(
      SyncStatusController(),
    ),
  );
  locator.registerLazySingleton<DbController>(() => DbController());
  locator.registerLazySingleton<AppSettingController>(
      () => AppSettingController());
}
void secondSetupLocator() {
  locator.registerLazySingleton<MainService>(
    () => MainService(locator<AppController>().baseURL),
  );
}

void resetLocatorWithNewBaseURL(String newBaseURL) {
  // Unregister the current MainService
  locator.unregister<MainService>();

  // Update the baseURL in AppController or wherever it is stored
  locator<AppController>().baseURL = newBaseURL;

  // Re-register the MainService with the new baseURL
  locator.registerLazySingleton<MainService>(
    () => MainService(newBaseURL),
  );
}
