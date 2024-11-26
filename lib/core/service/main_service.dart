import 'package:nfc_petro/core/service/all_services.dart';

class MainService {
  final String baseUrl;

  late final EquipmentService equipmentService;
  late final InsertService insertService;
  late final LogSheetsService logSheetsService;
  late final ParameterService parameterService;
  late final PhotoService photoService;
  late final RFIDService rfidService;
  late final RoleService roleService;
  late final UnitService unitService;
  late final UnitCategoryService unitCategoryService;
  late final UserService userService;
  late final CheckAPI checkAPI;

  MainService(this.baseUrl) {
    equipmentService = EquipmentService(baseUrl);
    insertService = InsertService(baseUrl);
    logSheetsService = LogSheetsService(baseUrl);
    parameterService = ParameterService(baseUrl);
    photoService = PhotoService(baseUrl);
    rfidService = RFIDService(baseUrl);
    roleService = RoleService(baseUrl);
    unitService = UnitService(baseUrl);
    unitCategoryService = UnitCategoryService(baseUrl);
    userService = UserService(baseUrl);
    checkAPI = CheckAPI(baseUrl);
  }

}
