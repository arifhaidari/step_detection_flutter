// import 'package:intl/intl.dart';

// import '../utils/z_utils_imports.dart';

// class TimeDivider {
//   static Map<String, List<int>> divideAndCalculateSteps(List<SensorData> sensorData) {
//     final startTime = sensorData.first.time;
//     final endTime = sensorData.last.time;
//     final duration = endTime.difference(startTime).inSeconds;

//     final partDuration = duration / 3;
//     final result = <String, List<int>>{};

//     for (var i = 0; i < 3; i++) {
//       final partStart = startTime.add(Duration(seconds: (partDuration * i).toInt()));
//       final partEnd = i == 2 ? endTime : startTime.add(Duration(seconds: (partDuration * (i + 1)).toInt()));

//       final partData = sensorData.where((data) => data.time.isAfter(partStart) && data.time.isBefore(partEnd)).toList();
//       final steps = StepCalculator.calculateSteps(partData);

//       final timeKey = DateFormat('mm:ss').format(partStart);
//       result[timeKey] = [steps['left_steps']!.first, steps['right_steps']!.first];
//     }

//     return result;
//   }
// }
