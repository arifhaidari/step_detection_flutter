export 'package:flutter/material.dart';
// home screen
export 'package:lucide_icons/lucide_icons.dart';
export 'package:step_detection_flutter/screens/prediction_screen.dart';
export 'package:step_detection_flutter/screens/prediction_list_api_screen.dart';
export 'package:step_detection_flutter/screens/prediction_analysis_screen.dart';
// measurement list
export 'package:step_detection_flutter/screens/measurement_list_screen.dart';
export 'package:step_detection_flutter/screens/raw_data_screen.dart';
export 'package:flutter/services.dart'; // For loading JSON from assets
export 'package:fl_chart/fl_chart.dart'; // For the chart
export 'dart:convert'; // For JSON decoding
export 'package:step_detection_flutter/models/measurement_model.dart';
export 'package:step_detection_flutter/models/sensor_data_model.dart';
export 'package:step_detection_flutter/widgets/down_sampling_sensor_data.dart';
export 'package:step_detection_flutter/utils/color_palette.dart';
// sensor data table
export 'package:pluto_grid/pluto_grid.dart';
export 'package:step_detection_flutter/utils/json_loader.dart';
// detail screen
export 'package:step_detection_flutter/providers/data_provider.dart';
export 'package:step_detection_flutter/screens/measurement_detail_screen.dart'; 
// prediction screen
export 'package:step_detection_flutter/providers/api_service.dart';
// prediction list api screen
export 'dart:io';
export 'package:file_picker/file_picker.dart';
export 'package:step_detection_flutter/utils/export_data_to_csv_json.dart';
// prediction analysis screen
export 'package:step_detection_flutter/utils/gait_analysis_report.dart';
export 'package:step_detection_flutter/widgets/prediction_graph.dart';
