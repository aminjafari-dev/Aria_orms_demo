import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbTableHelper {
  static const _databaseName = "ORMSAndroid.db";
  static const _databaseVersion = 1;

  // Singleton pattern to ensure one instance of the DB
  static final DbTableHelper instance = DbTableHelper._privateConstructor();
  static Database? _database;

  DbTableHelper._privateConstructor();

  Future<Database?> get database async {
    try {
      if (_database != null) return _database;

      _database = await _initDatabase();
      return _database;
    } catch (e) {
      Get.snackbar("Error", "Couldn't Find Database");
      return null;
    }
  }


Future<Database> _initDatabase() async {
  // Get the path to the device's writable directory
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, _databaseName);

  // Ensure the directory exists
  if (!(await Directory(databasesPath).exists())) {
    try {
      // Create the directory if it doesn't exist
      await Directory(databasesPath).create(recursive: true);
    } catch (e) {
      print("Error creating directory: $e");
    }
  }

  // Check if the database already exists
  bool exists = await databaseExists(path);

  if (!exists) {
    // If it doesn't exist, copy it from assets
    print("Creating new copy of the database");
    try {
      // Load asset
      ByteData data = await rootBundle.load("assets/db/$_databaseName");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Write the bytes to the file
      await File(path).writeAsBytes(bytes);
    } catch (e) {
      print("Error copying database: $e");
    }
  } else {
    print("Opening existing database");
  }

  // Open the database
  return await openDatabase(path, version: _databaseVersion);
}
}
