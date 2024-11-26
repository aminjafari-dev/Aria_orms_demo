import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/router/page_router.dart';
import 'package:nfc_petro/core/data%20base/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  await DbTableHelper.instance.database;
  // await initializeService();
  runApp(const MyApp());
}

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       onStart: onStart,
//       autoStart: true,
//       isForegroundMode: true,
//     ),
//     iosConfiguration: IosConfiguration(
//       autoStart: true,
//       onForeground: onStart,
//       onBackground: onIosBackground,
//     ),
//   );
//   service.startService();
// }

// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();

//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });

//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }

//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });

//   // Start NFC scanning
//   const platform = MethodChannel('com.dpsha.ariaorms/nfc');
//   try {
//     await platform.invokeMethod('startNfcScan');
//   } catch (e) {
//     print('Failed to start NFC scan: $e');
//   }

//   // Listen for NFC detections
//   platform.setMethodCallHandler((call) async {
//     if (call.method == 'onNfcDetected') {
//       final nfcData = call.arguments as String;
//       // Handle the NFC data here
//       print('NFC Data received: $nfcData');
//       // You can send this data to the UI using the service.invoke method
//       service.invoke(
//         'update',
//         {
//           'nfcData': nfcData,
//         },
//       );
//     }
//   });
// }

// @pragma('vm:entry-point')
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//   return true;
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future initDatabase() async {
    Database? db = await DbTableHelper.instance.database;

    if (db != null) {
      locator<AppController>().db = db;
    }
  }

  @override
  Widget build(BuildContext context) {
    initDatabase();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: PageRouter.routes,
      initialRoute: PageName.initPage,
      // home: NfcScanPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: PetroColors.white,
        primaryColor: Colors.white,
        cardColor: Colors.blueGrey,
      ),
    );
  }
}

class NfcScanPage extends StatefulWidget {
  const NfcScanPage({super.key});

  @override
  _NfcScanPageState createState() => _NfcScanPageState();
}

class _NfcScanPageState extends State<NfcScanPage> {
  static const platform = MethodChannel('com.dpsha.ariaorms/nfc');
  String _nfcData = 'No NFC data';

  @override
  void initState() {
    super.initState();
    _setupNfcListener();
  }

  Future<void> _setupNfcListener() async {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'onNfcDetected') {
        setState(() {
          _nfcData = call.arguments;
        });
      }
    });
  }

  Future<void> _startNfcScan() async {
    try {
      await platform.invokeMethod('startNfcScan');
    } on PlatformException catch (e) {
      print("Failed to start NFC scan: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('NFC Data: $_nfcData'),
            ElevatedButton(
              onPressed: _startNfcScan,
              child: const Text('Start NFC Scan'),
            ),
          ],
        ),
      ),
    );
  }
}
