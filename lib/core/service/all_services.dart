import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nfc_petro/core/controller/loading_controller.dart';
import 'package:nfc_petro/core/data%20base/db_controller.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/model/model.dart';
import 'package:nfc_petro/core/service/main_service.dart';

class EquipmentService {
  final String baseUrl;

  EquipmentService(this.baseUrl);

  Future<bool> getEquipments({int pageNo = 1, int pageSize = 100}) async {
    final uri = Uri.parse('$baseUrl/api/Equipment').replace(queryParameters: {
      'pageNo': pageNo.toString(),
      'pageSize': pageSize.toString(),
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      PaginatedResponse paginationResult = PaginatedResponse.fromJson(
          json.decode(response.headers['x-pagination'].toString()));

      //? call loading controller
      locator<LoadingController>().setLoadingParameters(
        paginatedRespons: paginationResult,
        showDialog: false,
      );

      //? inserting to database
      List<EquipmentDTO> result =
          jsonList.map((json) => EquipmentDTO.fromJson(json)).toList();
      for (var item in result) {
        await locator<DbController>().insertEquipment(item);
      }

      //? pagination
      if (paginationResult.hasNext) {
        int page = pageNo + 1;
        await getEquipments(pageNo: page, pageSize: pageSize);
      }
      return true;
    } else {
      throw Exception('Failed to load equipments');
    }
  }
}

class LogSheetsService {
  final String baseUrl;

  LogSheetsService(this.baseUrl);

  Future<bool> getLogSheets({int pageNo = 1, int pageSize = 100}) async {
    final uri = Uri.parse('$baseUrl/api/LogSheets').replace(queryParameters: {
      'pageNo': pageNo.toString(),
      'pageSize': pageSize.toString(),
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      PaginatedResponse paginationResult = PaginatedResponse.fromJson(
          json.decode(response.headers['x-pagination'].toString()));

      //? call loading controller
      locator<LoadingController>().setLoadingParameters(
        paginatedRespons: paginationResult,
        showDialog: false,
      );

      //? inserting to database
      List<LogSheetDTO> results =
          jsonList.map((json) => LogSheetDTO.fromJson(json)).toList();

      for (var item in results) {
        await locator<DbController>().insertLogSheet(item);
      }

      //? pagination
      if (paginationResult.hasNext) {
        int page = pageNo + 1;
        await getLogSheets(pageNo: page, pageSize: pageSize);
      }
      return true;
    } else {
      throw Exception('Failed to load log sheets');
    }
  }
}

class ParameterService {
  final String baseUrl;

  ParameterService(this.baseUrl);

  Future<bool> getParameters({int pageNo = 1, int pageSize = 100}) async {
    final uri = Uri.parse('$baseUrl/api/Parameter').replace(queryParameters: {
      'pageNo': pageNo.toString(),
      'pageSize': pageSize.toString(),
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      PaginatedResponse paginationResult = PaginatedResponse.fromJson(
          json.decode(response.headers['x-pagination'].toString()));

      //? call loading controller
      locator<LoadingController>().setLoadingParameters(
        paginatedRespons: paginationResult,
        showDialog: false,
      );

      //? inserting to database
      List<ParameterDTO> results =
          jsonList.map((json) => ParameterDTO.fromJson(json)).toList();

      for (var item in results) {
        await locator<DbController>().insertParameter(item);
      }

      //? pagination
      if (paginationResult.hasNext) {
        int page = pageNo + 1;
        await getParameters(pageNo: page, pageSize: pageSize);
      }
      return true;
    } else {
      throw Exception('Failed to load parameters');
    }
  }
}

class PhotoService {
  final String baseUrl;

  PhotoService(this.baseUrl);
  Future<bool> uploadPhoto(
    File file,
    int plantId,
    int userId,
    DateTime takeTime,
    String remark, {
    int? unitId,
    int? equipmentId,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/api/Photo"),
      );

// Add the file to the request
      request.files.add(await http.MultipartFile.fromPath(
        'file', // This should match the parameter name expected by your API
        file.path,
        filename: '$takeTime.jpg',
      ));

// Add the other fields to the request
      request.fields['PlantId'] = plantId.toString();
      request.fields['UserId'] = userId.toString();
      request.fields['TakeTime'] = takeTime.toIso8601String();
      request.fields['Remark'] = remark;
      if (unitId != null) {
        request.fields['unitId'] = unitId.toString();
      }
      if (equipmentId != null) {
        request.fields['equipmentId'] = equipmentId.toString();
      }

// Send the request
      var response = await request.send();

// Check the response status
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}

class InsertService {
  final String baseUrl;

  InsertService(this.baseUrl);

  Future<bool> postReadOut(ReadOutDTO readOutDTO) async {
    var body = json.encode(readOutDTO.toJson());
    final response = await http.post(
      Uri.parse('$baseUrl/api/Insert'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

class RFIDService {
  final String baseUrl;

  RFIDService(this.baseUrl);

  Future<bool> getRFIDs({int pageNo = 1, int pageSize = 100}) async {
    final uri = Uri.parse('$baseUrl/api/RFID').replace(queryParameters: {
      'pageNo': pageNo.toString(),
      'pageSize': pageSize.toString(),
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      PaginatedResponse paginationResult = PaginatedResponse.fromJson(
          json.decode(response.headers['x-pagination'].toString()));

      //? call loading controller
      locator<LoadingController>().setLoadingParameters(
        paginatedRespons: paginationResult,
        showDialog: false,
      );

      //? inserting to database
      List<RFIDDTO> results =
          jsonList.map((json) => RFIDDTO.fromJson(json)).toList();

      for (var item in results) {
        await locator<DbController>().insertRFID(item);
      }

      //? pagination
      if (paginationResult.hasNext) {
        int page = pageNo + 1;
        await getRFIDs(pageNo: page, pageSize: pageSize);
      }
      return true;
    } else {
      throw Exception('Failed to load RFIDs');
    }
  }
}

class RoleService {
  final String baseUrl;

  RoleService(this.baseUrl);

  Future<void> getRoles({int pageNo = 1, int pageSize = 100}) async {
    final uri = Uri.parse('$baseUrl/api/Role').replace(queryParameters: {
      'pageNo': pageNo.toString(),
      'pageSize': pageSize.toString(),
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      PaginatedResponse paginationResult = PaginatedResponse.fromJson(
          json.decode(response.headers['x-pagination'].toString()));

      //? call loading controller
      locator<LoadingController>().setLoadingParameters(
        paginatedRespons: paginationResult,
        showDialog: true,
      );

      //? inserting to database
      List<RoleDTO> results =
          jsonList.map((json) => RoleDTO.fromJson(json)).toList();

      for (var item in results) {
        await locator<DbController>().insertRole(item);
      }

      //? pagination
      if (paginationResult.hasNext) {
        int page = pageNo + 1;
        getRoles(pageNo: page, pageSize: pageSize);
      }
    } else {
      throw Exception('Failed to load roles');
    }
  }
}

class UnitService {
  final String baseUrl;

  UnitService(this.baseUrl);

  Future<bool> getUnits({int pageNo = 1, int pageSize = 100}) async {
    final uri = Uri.parse('$baseUrl/api/Unit').replace(queryParameters: {
      'pageNo': pageNo.toString(),
      'pageSize': pageSize.toString(),
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      PaginatedResponse paginationResult = PaginatedResponse.fromJson(
          json.decode(response.headers['x-pagination'].toString()));

      //? call loading controller
      locator<LoadingController>().setLoadingParameters(
        paginatedRespons: paginationResult,
        showDialog: false,
      );

      //? inserting to database
      List<UnitDTO> result =
          jsonList.map((json) => UnitDTO.fromJson(json)).toList();

      for (var item in result) {
        await locator<DbController>().insertUnit(item);
      }
      return true;
    } else {
      throw Exception('Failed to load units');
    }
  }
}

class UnitCategoryService {
  final String baseUrl;

  UnitCategoryService(this.baseUrl);

  Future<bool> getUnitCategories({int pageNo = 1, int pageSize = 100}) async {
    final uri =
        Uri.parse('$baseUrl/api/UnitCategory').replace(queryParameters: {
      'pageNo': pageNo.toString(),
      'pageSize': pageSize.toString(),
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      PaginatedResponse paginationResult = PaginatedResponse.fromJson(
          json.decode(response.headers['x-pagination'].toString()));

      //? call loading controller
      locator<LoadingController>().setLoadingParameters(
        paginatedRespons: paginationResult,
        showDialog: false,
      );

      //? inserting to database
      List<UnitCategoryDTO> result =
          jsonList.map((json) => UnitCategoryDTO.fromJson(json)).toList();

      for (var item in result) {
        await locator<DbController>().insertUnitCategory(item);
      }
      return true;
    } else {
      throw Exception('Failed to load unit categories');
    }
  }
}

class UserService {
  final String baseUrl;

  UserService(this.baseUrl);

  Future<void> getUsers({int pageNo = 1, int pageSize = 100}) async {
    final uri = Uri.parse('$baseUrl/api/User').replace(queryParameters: {
      'pageNo': pageNo.toString(),
      'pageSize': pageSize.toString(),
    });

    final response = await http.get(uri).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      PaginatedResponse paginationResult = PaginatedResponse.fromJson(
          json.decode(response.headers['x-pagination'].toString()));

      //? call loading controller
      locator<LoadingController>().setLoadingParameters(
        paginatedRespons: paginationResult,
        showDialog: true,
      );

      //? inserting to database
      List<UserDTO> users =
          jsonList.map((json) => UserDTO.fromJson(json)).toList();

      for (var user in users) {
        await locator<DbController>().insertUser(user);
      }

      //? pagination
      if (paginationResult.hasNext) {
        int page = pageNo + 1;
        getUsers(pageNo: page, pageSize: pageSize);
      } else {
        locator<MainService>().roleService.getRoles();
      }
    } else {
      throw Exception('Failed to load users');
    }
  }
}

class CheckAPI {
  final String baseUrl;

  CheckAPI(this.baseUrl);

  Future<bool> apiCheck1() async {
    final url = Uri.parse('$baseUrl/api/Check');

    try {
      final response = await http.get(url).timeout(Durations.short4);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> apiCheck() async {
    int count = 0;
    int maximumTry = 5;
    while (count < maximumTry) {
      count++;
      log(count.toString());
      bool result = await apiCheck1();
      if (result) {
        return true;
      }
    }

    Get.snackbar("Connection Error", "Please check your network");
    return false;
  }
}
