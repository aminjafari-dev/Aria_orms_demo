
// EquipmentDTO Model
class EquipmentDTO {
  final int? equipmentId;
  final String? equipmentType;
  final String? equipmentNo;
  final int? unitId;

  EquipmentDTO({
    this.equipmentId,
    this.equipmentType,
    this.equipmentNo,
    this.unitId,
  });

  factory EquipmentDTO.fromJson(Map<String, dynamic> json) {
    return EquipmentDTO(
      equipmentId: json['equipmentId'] as int?,
      equipmentType: json['equipmentType'] as String?,
      equipmentNo: json['equipmentNo'] as String?,
      unitId: json['unitId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'equipmentId': equipmentId,
      'equipmentType': equipmentType,
      'equipmentNo': equipmentNo,
      'unitId': unitId,
    };
  }
}

// LogSheetDTO Model
class LogSheetDTO {
  final int? logSheetId;
  final String? logSheetName;
  final String? logSheetNo;
  final int? unitCategoryId;
  final bool? siteLog;
  final List<String>? fillTimes;
  final List<LogSheetScope>? logSheetScopes;

  LogSheetDTO({
    this.logSheetId,
    this.logSheetName,
    this.logSheetNo,
    this.unitCategoryId,
    this.siteLog,
    this.fillTimes,
    this.logSheetScopes,
  });

  factory LogSheetDTO.fromJson(Map<String, dynamic> json) {
    return LogSheetDTO(
      logSheetId: json['logSheetId'] as int?,
      logSheetName: json['logSheetName'] as String?,
      logSheetNo: json['logSheetNo'] as String?,
      unitCategoryId: json['unitCategoryId'] as int?,
      siteLog: json['siteLog'] as bool?,
      fillTimes: (json['fillTimes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      logSheetScopes: (json['logSheetScopes'] as List<dynamic>?)
          ?.map((e) => LogSheetScope.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logSheetId': logSheetId,
      'logSheetName': logSheetName,
      'logSheetNo': logSheetNo,
      'unitCategoryId': unitCategoryId,
      'siteLog': siteLog,
      'fillTimes': fillTimes,
      'logSheetScopes': logSheetScopes?.map((e) => e.toJson()).toList(),
    };
  }
}

// LogSheetScope Model
class LogSheetScope {
  final int? parameterId;
  final int? orderNo;

  LogSheetScope({
    this.parameterId,
    this.orderNo,
  });

  factory LogSheetScope.fromJson(Map<String, dynamic> json) {
    return LogSheetScope(
      parameterId: json['parameterId'] as int?,
      orderNo: json['orderNo'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parameterId': parameterId,
      'orderNo': orderNo,
    };
  }
}

// ParameterDTO Model
class ParameterDTO {
  final int? parameterId;
  final String? title;
  final String? tag;
  final String? uom;
  final String? dataType;
  final String? entryStyle;
  final String? sign;
  final double? lower;
  final double? upper;
  final String? rfidTag;
  final int? equipmentId;
  final String? equipmentName;
  final int? unitId;
  final String? unitTag;
  final int? categoryId;
  final String? category;
  final List<ParameterOptionsDTO>? options;

  ParameterDTO({
    this.parameterId,
    this.title,
    this.tag,
    this.uom,
    this.dataType,
    this.entryStyle,
    this.sign,
    this.lower,
    this.upper,
    this.rfidTag,
    this.equipmentId,
    this.equipmentName,
    this.unitId,
    this.unitTag,
    this.categoryId,
    this.category,
    this.options,
  });

  factory ParameterDTO.fromJson(Map<String, dynamic> json) {
    return ParameterDTO(
      parameterId: json['parameterId'] as int?,
      title: json['title'] as String?,
      tag: json['tag'] as String?,
      uom: json['uom'] as String?,
      dataType: json['dataType'] as String?,
      entryStyle: json['entryStyle'] as String?,
      sign: json['sign'] as String?,
      lower: (json['lower'] as num?)?.toDouble(),
      upper: (json['upper'] as num?)?.toDouble(),
      rfidTag: json['rfidTag'] as String?,
      equipmentId: json['equipmentId'] as int?,
      equipmentName: json['equipmentName'] as String?,
      unitId: json['unitId'] as int?,
      unitTag: json['unitTag'] as String?,
      categoryId: json['categoryId'] as int?,
      category: json['category'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => ParameterOptionsDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parameterId': parameterId,
      'title': title,
      'tag': tag,
      'uom': uom,
      'dataType': dataType,
      'entryStyle': entryStyle,
      'sign': sign,
      'lower': lower,
      'upper': upper,
      'rfidTag': rfidTag,
      'equipmentId': equipmentId,
      'equipmentName': equipmentName,
      'unitId': unitId,
      'unitTag': unitTag,
      'categoryId': categoryId,
      'category': category,
      'options': options?.map((e) => e.toJson()).toList(),
    };
  }
}

// ParameterOptionsDTO Model
class ParameterOptionsDTO {
  final int? parameterId;
  final String? optionText;
  final int? orderNo;

  ParameterOptionsDTO({
    this.parameterId,
    this.optionText,
    this.orderNo,
  });

  factory ParameterOptionsDTO.fromJson(Map<String, dynamic> json) {
    return ParameterOptionsDTO(
      parameterId: json['parameterId'] as int?,
      optionText: json['optionText'] as String?,
      orderNo: json['orderNo'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parameterId': parameterId,
      'optionText': optionText,
      'orderNo': orderNo,
    };
  }
}

// PhotoDTO Model
class PhotoDTO {
  final int? photoId;
  final int? plantId;
  final int? unitId;
  final int? equipmentId;
  final int? userId;
  final DateTime? takeTime;
  final String? remark;
  final String? file;

  PhotoDTO({
    this.photoId,
    this.plantId,
    this.unitId,
    this.equipmentId,
    this.userId,
    this.takeTime,
    this.remark,
    this.file,
  });

  factory PhotoDTO.fromJson(Map<String, dynamic> json) {
    return PhotoDTO(
      photoId: json['ID'],
      plantId: json['PlantID'],
      unitId: json['UnitID'],
      equipmentId: json['EquipmentID'],
      userId: json['UserID'],
      takeTime:
          json['TakeTime'] != null ? DateTime.parse(json['TakeTime']) : null,
      remark: json['Remark'],
      file: json['PhotoPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': photoId,
      'PlantID': plantId,
      'UnitID': unitId,
      'EquipmentID': equipmentId,
      'UserID': userId,
      'TakeTime':takeTime?.toIso8601String(),
      'Remark': remark,
      'PhotoPath': file,
    };
  }
}

// RFIDDTO Model
class RFIDDTO {
  final int? id;
  final String? tag;
  final int? plantId;
  final String? location;

  RFIDDTO({
    this.id,
    this.tag,
    this.plantId,
    this.location,
  });

  factory RFIDDTO.fromJson(Map<String, dynamic> json) {
    return RFIDDTO(
      id: json['id'] as int?,
      tag: json['tag'] as String?,
      plantId: json['plantId'] as int?,
      location: json['location'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tag': tag,
      'plantId': plantId,
      'location': location,
    };
  }
}

// ReadOutDTO Model
class ReadOutDTO {
  final String? value;
  final int? userId;
  final DateTime? dataCollectorFillTime;
  final DateTime? fillTime;
  final int? parameterId;

  ReadOutDTO({
    this.value,
    this.userId,
    this.dataCollectorFillTime,
    this.fillTime,
    this.parameterId,
  });

  factory ReadOutDTO.fromJson(Map<String, dynamic> json) {
    return ReadOutDTO(
      value: json['value'] as String?,
      userId: json['userId'] as int?,
      dataCollectorFillTime: json['dataCollectorFillTime'] != null
          ? DateTime.parse(json['dataCollectorFillTime'])
          : null,
      fillTime:
          json['fillTime'] != null ? DateTime.parse(json['fillTime']) : null,
      parameterId: json['parameterId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'userId': userId,
      'dataCollectorFillTime': dataCollectorFillTime!.toIso8601String(),
      'fillTime': fillTime!.toIso8601String(),
      'parameterId': parameterId,
    };
  }
}

// RoleDTO Model
class RoleDTO {
  final int? roleId;
  final String? roleTitle;
  final bool? getDataCollector;
  final List<RoleDetails>? details;

  RoleDTO({
    this.roleId,
    this.roleTitle,
    this.getDataCollector,
    this.details,
  });

  factory RoleDTO.fromJson(Map<String, dynamic> json) {
    return RoleDTO(
      roleId: json['roleId'] as int?,
      roleTitle: json['roleTitle'] as String?,
      getDataCollector: json['getDataCollector'] as bool?,
      details: (json['details'] as List<dynamic>?)
          ?.map((e) => RoleDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roleId': roleId,
      'roleTitle': roleTitle,
      'getDataCollector': getDataCollector,
      'details': details?.map((e) => e.toJson()).toList(),
    };
  }
}

// RoleDetails Model
class RoleDetails {
  final int? objectId;
  final int? objectType;

  RoleDetails({
    this.objectId,
    this.objectType,
  });

  factory RoleDetails.fromJson(Map<String, dynamic> json) {
    return RoleDetails(
      objectId: json['objectId'] as int?,
      objectType: json['objectType'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectId': objectId,
      'objectType': objectType,
    };
  }
}

// UnitCategoryDTO Model
class UnitCategoryDTO {
  final int? unitCategoryId;
  final String? unitCategory;

  UnitCategoryDTO({
    this.unitCategoryId,
    this.unitCategory,
  });

  factory UnitCategoryDTO.fromJson(Map<String, dynamic> json) {
    return UnitCategoryDTO(
      unitCategoryId: json['unitCategoryId'] as int?,
      unitCategory: json['unitCategory'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unitCategoryId': unitCategoryId,
      'unitCategory': unitCategory,
    };
  }
}

// UnitDTO Model
class UnitDTO {
  final int? unitId;
  final String? unitName;
  final String? unitTag;
  final int? unitCategoryId;

  UnitDTO({
    this.unitId,
    this.unitName,
    this.unitTag,
    this.unitCategoryId,
  });

  factory UnitDTO.fromJson(Map<String, dynamic> json) {
    return UnitDTO(
      unitId: json['unitId'] as int?,
      unitName: json['unitName'] as String?,
      unitTag: json['unitTag'] as String?,
      unitCategoryId: json['unitCategoryId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unitId': unitId,
      'unitName': unitName,
      'unitTag': unitTag,
      'unitCategoryId': unitCategoryId,
    };
  }
}

// UserDTO Model
class UserDTO {
  final int? userId;
  final String? userName;
  final String? password;
  final int? roleId;
  final String? name;
  final String? family;

  UserDTO({
    this.userId,
    this.userName,
    this.password,
    this.roleId,
    this.name,
    this.family,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      userId: json['userId'] as int?,
      userName: json['userName'] as String?,
      password: json['password'] as String?,
      roleId: json['roleId'] as int?,
      name: json['name'] as String?,
      family: json['family'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'password': password,
      'roleId': roleId,
      'name': name,
      'family': family,
    };
  }
}

class PaginatedResponse {
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalCount;
  final bool hasPrevious;
  final bool hasNext;
  final String action;

  PaginatedResponse({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
    required this.hasPrevious,
    required this.hasNext,
    required this.action,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedResponse(
      currentPage: json['CurrentPage'] as int,
      totalPages: json['TotalPages'] as int,
      pageSize: json['PageSize'] as int,
      totalCount: json['TotalCount'] as int,
      hasPrevious: json['HasPrevious'] as bool,
      hasNext: json['HasNext'] as bool,
      action: json['Action'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CurrentPage': currentPage,
      'TotalPages': totalPages,
      'PageSize': pageSize,
      'TotalCount': totalCount,
      'HasPrevious': hasPrevious,
      'HasNext': hasNext,
      'Action': action,
    };
  }
}
