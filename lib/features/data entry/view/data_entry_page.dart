import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_detection/keyboard_detection.dart';
import 'package:nfc_petro/config/petro_colors.dart';
import 'package:nfc_petro/config/petro_extentions.dart';
import 'package:nfc_petro/config/petro_padding.dart';
import 'package:nfc_petro/config/petro_string.dart';
import 'package:nfc_petro/core/get%20it/locator.dart';
import 'package:nfc_petro/core/widgets/petro_app_bar.dart';
import 'package:nfc_petro/core/widgets/bottom_widget.dart';
import 'package:nfc_petro/core/widgets/petro_button.dart';
import 'package:nfc_petro/core/widgets/petro_drop_down.dart';
import 'package:nfc_petro/core/widgets/petro_gap.dart';
import 'package:nfc_petro/core/widgets/petro_text.dart';
import 'package:nfc_petro/core/widgets/petro_text_field.dart';
// import 'package:nfc_petro/features/data%20entry/model/chart_data_mode.dart';
import 'package:nfc_petro/features/home/view/widgets/app_drawer.dart';
import 'package:nfc_petro/features/log%20sheet/controller/log_sheet_controller.dart';
import 'package:nfc_petro/features/log%20sheet/model/parameter_model.dart';
import 'package:nfc_petro/features/log%20sheet/model/read_out_model.dart';
// import 'package:syncfusion_flutter_charts/charts.dart'; // Add this package for the chart

class DataEntryPage extends StatefulWidget {
  const DataEntryPage({super.key});

  @override
  State<DataEntryPage> createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  final LogSheetController _logSheetController = locator<LogSheetController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isInRange = true;
  late ParameterModel item;
  String? selectedValue; // This holds the currently selected value

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LogSheetController>(
      builder: (controller) {
        if (_logSheetController.parametersList.isNotEmpty) {
          item = _logSheetController
              .parametersList[_logSheetController.indexParameterSelectedGetter];
        }
        return SafeArea(
          child: KeyboardDetection(
            controller: KeyboardDetectionController(
              onChanged: (state) {
                if (KeyboardState.visible == state) {
                  _logSheetController.dataEntryPageKeyboardIsOpen = true;
                }
                if (KeyboardState.hidden == state) {
                  _logSheetController.dataEntryPageKeyboardIsOpen = false;
                }
              },
            ),
            child: Scaffold(
                drawer: const AppDrawer(),
                key: scaffoldKey,
                appBar: _logSheetController.dataEntryPageKeyboardIsOpen
                    ? null
                    : PetroAppBar(
                        title: "Data Entry Window",
                        subTitle: item.equipmentName,
                        onPressed: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PetroGap.gap_30,
                      Padding(
                        padding: PetroPadding.h_20,
                        child: PetroText(
                          "${item.title} [${item.tag}]",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PetroGap.gap_8,

                      //? Show textfield or DropDown box
                      Padding(
                        padding: PetroPadding.h_20,
                        child: item.entryStyle == "Typing"
                            ? Form(
                                key: _formKey,
                                child: PetroTextField(
                                  hint: PetroString.pleaseEnterValue,
                                  controller: _logSheetController
                                      .textEditingControllerDataEntryPage,
                                  fillColor: isInRange
                                      ? null
                                      : PetroColors.red.withOpacity(.3),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Value cannot be blank";
                                    } else if (item.dataType == "Number") {}
                                    return null;
                                  },
                                  autoFocus: true,
                                  textInputType: item.dataType == "Number"
                                      ? TextInputType.number
                                      : TextInputType.text,
                                ),
                              )
                            : PetroDropDown(
                                items: _logSheetController.dropDownOptions,
                                initValue: item.value,
                                onChanged: (v) {
                                  if (v != null) {
                                    _logSheetController.changeValue(v);
                                    _logSheetController.update();
                                  }
                                },
                              ),
                      ),
                      Padding(
                        padding: PetroPadding.h_20,
                        child: Row(
                          children: [
                            Expanded(
                              child: PetroText(
                                _showTheRange(),
                                textAlign: TextAlign.left,
                                size: 16,
                                color: PetroColors.blue,
                              ),
                            ),
                            Expanded(
                              child: PetroText(
                                item.uom ?? '',
                                size: 16,
                                textAlign: TextAlign.right,
                                color: PetroColors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PetroGap.gap_20,
                      // Chart Section
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 20.0),
                      //   child: SizedBox(height: 334, child: _showChart(item)),
                      // ),
                      // PetroGap.gap_20,
                      // Data Table Section
                      _showTable(),
                      PetroGap.gap_60,
                      PetroGap.gap_60,
                    ],
                  ),
                ),
                bottomSheet: _bottomSheet(context)),
          ),
        );
      },
    );
  }

  Widget _bottomSheet(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Navigation Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PetroGap.gap_20,
            Expanded(
              child: PetroButton(
                text: isInRange ? PetroString.back : PetroString.accept,
                backgroundColor: isInRange ? null : PetroColors.red,
                onPressed: () {
                  if (item.entryStyle!.toLowerCase() == "select") {
                    backButtonFunction(selectable: true);
                  } else {
                    if (_formKey.currentState!.validate()) {
                      double value = double.parse(_logSheetController
                          .textEditingControllerDataEntryPage.text);
                      if (_isInRange(value) || isInRange == false) {
                        isInRange = true;
                        backButtonFunction();
                      } else {
                        isInRange = false;
                        Get.snackbar("Warning", "Your value is out of range");
                        setState(() {});
                      }
                    }
                  }
                },
              ),
            ),
            PetroGap.gap_20,
            Expanded(
              child: PetroButton(
                  text: isInRange ? PetroString.next : PetroString.accept,
                  backgroundColor: isInRange ? null : PetroColors.red,
                  onPressed: () {
                    if (item.entryStyle!.toLowerCase() == "select") {
                      nextButtonFunction(selectable: true);
                    } else {
                      if (_formKey.currentState!.validate()) {
                        double value = double.parse(_logSheetController
                            .textEditingControllerDataEntryPage.text);
                        if (_isInRange(value) || isInRange == false) {
                          isInRange = true;
                          nextButtonFunction();
                        } else {
                          isInRange = false;
                          Get.snackbar("Warning", "Your value is out of range");
                          setState(() {});
                        }
                      }
                    }
                  }),
            ),
            PetroGap.gap_20,
          ],
        ),
        PetroGap.gap_8,
        BottomWidget(),
      ],
    );
  }

  // Widget _showChart(ParameterModel item) {
  //   return SfCartesianChart(
  //     primaryXAxis: const CategoryAxis(
  //       title: AxisTitle(text: PetroString.time),
  //       borderColor: PetroColors.darkBlue,
  //     ),
  //     primaryYAxis: NumericAxis(
  //       maximum: _logSheetController.highValueChart,
  //       interval: 1,
  //       minimum: _logSheetController.lowValueChart,
  //       title: const AxisTitle(text: PetroString.value),
  //       axisLine: const AxisLine(color: PetroColors.darkBlue),
  //       plotBands: <PlotBand>[
  //         PlotBand(
  //           isVisible: true,
  //           start: item.min,
  //           end: item.min,
  //           borderColor: PetroColors.red,
  //           borderWidth: 1,
  //           text: "Min",
  //           verticalTextAlignment: TextAnchor.start,
  //           horizontalTextAlignment: TextAnchor.start,
  //           textStyle: const TextStyle(color: PetroColors.red, fontSize: 9),
  //         ),
  //         PlotBand(
  //           isVisible: true,
  //           text: "Max",
  //           verticalTextAlignment: TextAnchor.start,
  //           textStyle: const TextStyle(color: PetroColors.red, fontSize: 9),
  //           horizontalTextAlignment: TextAnchor.start,
  //           start: item.max,
  //           end: item.max,
  //           borderColor: PetroColors.red,
  //           borderWidth: 1,
  //         ),
  //       ],
  //     ),
  //     plotAreaBorderColor: PetroColors.darkBlue,
  //     borderWidth: 2,
  //     series: [
  //       SplineSeries<ChartDataModel, int>(
  //         dataSource: _logSheetController.chartDataModel,
  //         xValueMapper: (ChartDataModel data, _) => data.x,
  //         yValueMapper: (ChartDataModel data, _) => data.y,
  //         dataLabelSettings: const DataLabelSettings(
  //           isVisible: true,
  //         ),
  //         markerSettings: const MarkerSettings(
  //           isVisible: true, // To show the markers
  //           shape: DataMarkerType.circle, // Defines the marker as a circle
  //           borderColor: PetroColors.red, // Customize the color of the circle
  //           borderWidth: 2, // Customize the border width
  //           color: PetroColors.white, // Fill color of the marker
  //           width: 8, // Customize the size of the circle
  //           height: 8,
  //         ),
  //       )
  //     ],
  //   );
  // }

  Widget _showTable() {
    return Padding(
      padding: PetroPadding.h_27,
      child: Table(
        border: const TableBorder(
          top: BorderSide(color: PetroColors.darkBlue),
          bottom: BorderSide(color: PetroColors.darkBlue),
          horizontalInside: BorderSide(color: PetroColors.darkBlue),
        ),
        columnWidths: const {
          0: FlexColumnWidth(2), // First column
          1: FlexColumnWidth(2), // Second column
          2: FlexColumnWidth(1), // Third column (half width)
        },
        children: [
          TableRow(
            decoration: const BoxDecoration(
              color: PetroColors.darkBlue,
            ),
            children: [
              "D/M/Y",
              "Time",
              "Value",
            ]
                .map((text) => Padding(
                      padding: PetroPadding.v_12,
                      child: Center(
                        child: PetroText(
                          text,
                          size: 16,
                          color: PetroColors.white,
                        ),
                      ),
                    ))
                .toList(),
          ),
          ...List.generate(_logSheetController.history.length, (index) {
            ReadOutModel item = _logSheetController.history[index];
            String value = item.value.toString();
            String time = "${item.fillTime!.hour}:${item.fillTime!.minute}"
                .showAtLeastTwoCharacters();
            String date =
                "${item.fillTime!.year}/${item.fillTime!.month}/${item.fillTime!.day}";
            return TableRow(
              decoration: BoxDecoration(
                  color: PetroColors.lightBlue,
                  border: Border.all(color: PetroColors.darkBlue)),
              children: [
                date,
                time,
                value,
              ]
                  .map((text) => Padding(
                        padding: PetroPadding.v_12,
                        child: Center(
                          child: PetroText(
                            text,
                            size: 16,
                            color: PetroColors.darkBlue,
                          ),
                        ),
                      ))
                  .toList(),
            );
          }),
        ],
      ),
    );
  }

  String _showTheRange() {
    int index = _logSheetController.indexParameterSelectedGetter;
    ParameterModel model = _logSheetController.parametersList[index];
    switch (model.sgin.toString().trim()) {
      case "Between":
        return "${model.min} - ${model.max}";
      case "<=":
        return model.sgin!.trim() + model.min.toString();
      case "<":
        return model.sgin!.trim() + model.min.toString();
      case ">=":
        return model.sgin!.trim() + model.min.toString();
      case ">":
        return model.sgin!.trim() + model.min.toString();
      case "=":
        return model.sgin!.trim() + model.min.toString();
      default:
        return "";
    }
  }

  bool _isInRange(double value) {
    int index = _logSheetController.indexParameterSelectedGetter;
    ParameterModel model = _logSheetController.parametersList[index];
    switch (model.sgin.toString().trim()) {
      case "Between":
        return (model.min! <= value && value <= model.max!);
      case "<=":
        return (value <= model.min!);
      case "<":
        return (value < model.min!);

      case ">=":
        return (value >= model.min!);

      case ">":
        return (value > model.min!);

      case "=":
        return (value == model.min!);

      default:
        return true;
    }
  }

//? Functions
  void nextButtonFunction({bool selectable = false}) {
    if (!selectable) {
      _logSheetController.changeValue(
        _logSheetController.textEditingControllerDataEntryPage.text,
      );
    }
    _logSheetController.textEditingControllerDataEntryPage.text = '';
    int lastParameterIndex = _logSheetController.parametersList.length - 1;
    if (_logSheetController.indexParameterSelectedGetter ==
        lastParameterIndex) {
      Navigator.pop(context);
    } else {
      _logSheetController.indexParameterSelectedSetter(
        _logSheetController.indexParameterSelectedGetter + 1,
      );
    }
  }

  void backButtonFunction({bool selectable = false}) {
    _logSheetController.changeValue(
      _logSheetController.textEditingControllerDataEntryPage.text,
    );
    _logSheetController.textEditingControllerDataEntryPage.text = '';
    if (_logSheetController.indexParameterSelectedGetter == 0) {
      Navigator.pop(context);
    } else {
      _logSheetController.indexParameterSelectedSetter(
        _logSheetController.indexParameterSelectedGetter - 1,
      );
    }
  }
}
