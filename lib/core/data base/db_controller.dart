import 'dart:developer';

import 'package:get/get.dart';
import 'package:nfc_petro/core/controller/app_controller.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/model/model.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
//? Database
  Database db = locator<AppController>().db;

//? inserting into database section
  Future<bool> insertEquipment(EquipmentDTO equipment) async {
    try {
      await db.rawInsert('''
      Insert Into Equipment (EquipmentID,EquipmentType,EquipmentNo,UnitID)
      Values
      (${equipment.equipmentId},'${equipment.equipmentType}','${equipment.equipmentNo}',${equipment.unitId})
''');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertLogSheet(LogSheetDTO logSheet) async {
    try {
      await db.rawInsert('''
      Insert Into LogSheet (LogSheetID,UnitCategoryID,LogName,LogNo,sitelog)
      Values
      (${logSheet.logSheetId},${logSheet.unitCategoryId},'${logSheet.logSheetName}','${logSheet.logSheetNo}',${logSheet.siteLog! ? '1' : '0'})
''');


      for (var x in logSheet.logSheetScopes!) {
        db.rawInsert('''
      Insert Into LogSheetScope (LogSheetID,ParameterID,OrderNo,ViewOrderNo,ID)
      Values
      (
        ${logSheet.logSheetId}
        ,${x.parameterId}
         ,${x.orderNo}
         ,${x.orderNo}
         ,1
      )
''');
      }

      for (var x in logSheet.fillTimes!) {
        db.rawInsert('''
      Insert Into LogSheetProgramDetail (LPID,FillTime,ID)
      Values
      (
        ${logSheet.logSheetId}
        ,'$x'
         ,1
      )
''');
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertParameter(ParameterDTO parameter) async {
    try {
      await db.rawInsert('''
      INSERT INTO Parameters 
      (ParameterID, Title, Tag, UnitMesserement, DataType, DataEntryStyle, EquipmentID, Sign, Lower, Upper, RFID, EquipmentName, UnitID, UnitTag, PlantID, PlantName) 
VALUES (${parameter.parameterId}, 
'${parameter.title}', 
'${parameter.tag}',
 '${parameter.uom}', 
 '${parameter.dataType}', 
 '${parameter.entryStyle}',
  ${parameter.equipmentId},
  '${parameter.sign}',
  ${parameter.lower}, 
  ${parameter.upper}, 
  '${parameter.rfidTag}',
  '${parameter.equipmentName}',
  ${parameter.unitId},
    '${parameter.unitTag}',
        ${parameter.categoryId},
         '${parameter.category}')
''');

      if (parameter.options != null) {
        for (var x in parameter.options!) {
          db.rawInsert('''
INSERT INTO ParameterOptions ( ParameterID, OptionText, OrderNo) VALUES ( ${
            parameter.parameterId
          }, '${x.optionText}', ${x.orderNo})
''');
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> insertPhoto(PhotoDTO photo) async {
    await db.insert(
      'Photo',
      photo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> insertRFID(RFIDDTO rfid) async {
    try {
      await db.rawInsert('''
INSERT INTO RFID (RFIDTag, Remark, ID, UnitCategoryID, Location) 
VALUES ('${rfid.tag}', '${rfid.location}', ${rfid.id}, ${rfid.plantId}, '${rfid.location}')
''');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertRole(RoleDTO role) async {
    try {
      await db.rawInsert('''
INSERT INTO PermissionCategory (CategoryID, Category, GetDataCollectorData) 
VALUES (${role.roleId}, '${role.roleTitle}', ${role.getDataCollector! ? "1" : "0"})
''');
      if (role.details != null) {
        for (var x in role.details!) {
          db.rawInsert('''
INSERT INTO PermissionDetails (PermissionCategoryID, ObjectID, TypeObject) VALUES 
(${role.roleId}, ${x.objectId}, ${x.objectType});
''');
          log("${role.roleId}, ${x.objectId}, ${x.objectType}");
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertUnit(UnitDTO unit) async {
    try {
      await db.rawInsert('''
INSERT INTO Unit (UnitID, UnitTag, UnitName, DocumentID, CategoryID) 
VALUES (${unit.unitId}, '${unit.unitTag}', '${unit.unitName}', '', ${unit.unitCategoryId});
''');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertUnitCategory(UnitCategoryDTO unitCategory) async {
    try {
      await db.rawInsert('''
INSERT INTO UnitCategory (CategoryID, Category, AccidentCodeTemplate, LastAccidentNo) 
VALUES (${unitCategory.unitCategoryId}, '${unitCategory.unitCategory}', '', 0)
''');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertUser(UserDTO user) async {
    try {
      await db.rawInsert('''
INSERT INTO Users (UserID, UserName, Password, CategoryID, Name, Family, Duty, LastChangeDate, DataCollectorPass, IsActiveDirecory, Email, MobileNo, IsEnable) 
VALUES (${user.userId}, '${user.userName}', '${user.password}', ${user.roleId}, '${user.name}', '${user.family}', 1.0, '2024-09-16 12:00:00', '${user.password}', 1, 'john.doe@example.com', '1234567890', 1)
''');
      return true;
    } catch (e) {
      log("dev-error -- inserting user to user database");
      Get.snackbar("dev-error", "inserting user to user database");
      return false;
    }
  }

//? Clearing database section

  Future<bool> clearUsersAndRoles() async {
    try {
      Future.wait([
        db.delete("Users"),
        db.delete("PermissionCategory"),
        db.delete("PermissionDetails"),
      ]);
      return true;
    } catch (e) {
      log("dev error -- clearing user db and roles");
      Get.snackbar("dev-error", "clearing user db and roles");
      return false;
    }
  }

  Future<bool> clearDBData() async {
    try {
      Future.wait([
        db.delete("Equipment"),
        db.delete("LogSheetScope"),
        db.delete("LogSheet"),
        db.delete("LogSheetProgramDetail"),
        db.delete("Parameters"),
        db.delete("RFID"),
        db.delete("ParameterOptions"),
        db.delete("Unit"),
        db.delete("UnitCategory"),
      ]);
      return true;
    } catch (e) {
      log("dev error -- clearing all database data");
      Get.snackbar("dev-error", "clearing all database data");
      return false;
    }
  }
}
