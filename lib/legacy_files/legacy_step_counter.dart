import 'package:scidart/numdart.dart';
import 'package:step_detection_flutter/providers/data_provider.dart';
import '../utils/z_utils_imports.dart';

import 'package:collection/collection.dart';

class StepCounter {
  List<SensorData> sensorData;

  StepCounter(this.sensorData);

  Map<String, Map<String, int>> countSteps() {
    // Group data by ID and Side
    var groupedData = groupBy(sensorData, (SensorData data) => '${data.id}-${data.side}');

    Map<String, Map<String, int>> stepCounts = {};

    groupedData.forEach((key, dataList) {
      if (dataList.isEmpty) return;

      String id = dataList.first.id;
      String side = dataList.first.side;

      double meanHeight = _calculateMean(dataList) + 0.5 * _calculateStd(dataList);
      double fs = 1 / _medianTimeDiff(dataList);
      int minDistance = (0.5 * fs).toInt();

      int steps = _findPeaks(dataList.map((e) => e.accMagnitude).toList(), meanHeight, minDistance);

      stepCounts.putIfAbsent(id, () => {});
      stepCounts[id]![side == 'L' ? 'left_steps' : 'right_steps'] = steps;
    });

    return stepCounts;
  }

  double _calculateMean(List<SensorData> data) {
    return data.map((e) => e.accMagnitude).reduce((a, b) => a + b) / data.length;
  }

  double _calculateStd(List<SensorData> data) {
    double mean = _calculateMean(data);
    double variance = data.map((e) => pow(e.accMagnitude - mean, 2)).reduce((a, b) => a + b) / data.length;
    return sqrt(variance);
  }

  double _medianTimeDiff(List<SensorData> data) {
    List<double> timeDiffs = data.map((e) => e.timeDiff).where((e) => e > 0).toList();
    timeDiffs.sort();
    int middle = timeDiffs.length ~/ 2;
    return timeDiffs.length % 2 == 1 ? timeDiffs[middle] : (timeDiffs[middle - 1] + timeDiffs[middle]) / 2;
  }

  int _findPeaks(List<double> series, double height, int minDistance) {
    List<int> peaks = [];
    for (int i = 1; i < series.length - 1; i++) {
      if (series[i] > height && series[i] > series[i - 1] && series[i] > series[i + 1]) {
        if (peaks.isEmpty || (i - peaks.last) >= minDistance) {
          peaks.add(i);
        }
      }
    }
    return peaks.length;
  }
}

void main() async {
  DataProvider dataProvider = DataProvider();
  List<SensorData> sensorData = await dataProvider.getSensorData();

  StepCounter stepCounter = StepCounter(sensorData);
  Map<String, Map<String, int>> stepCounts = stepCounter.countSteps();

  print(stepCounts);
}


// class StepCalculator {
//   static Map<String, List<int>> calculateSteps(List<SensorData> sensorData) {
//     // Calculate mean height and minimum distance
//     final accMagnitudes = sensorData.map((data) => data.accMagnitude).toList();
//     final meanHeight = _calculateMean(accMagnitudes) + 0.5 * _calculateStd(accMagnitudes);
//     final timeDiffs = sensorData.map((data) => data.timeDiff).toList();
//     final fs = 1 / _calculateMedian(timeDiffs);
//     final minDistance = (0.5 * fs).toInt();

//     // Function to count peaks
//     int countPeaks(List<double> series, double height, int distance) {
//       final peaks = <int>[];
//       for (var i = 1; i < series.length - 1; i++) {
//         if (series[i] > height && series[i] > series[i - 1] && series[i] > series[i + 1]) {
//           if (peaks.isEmpty || (i - peaks.last) >= distance) {
//             peaks.add(i);
//           }
//         }
//       }
//       return peaks.length;
//     }

//     // Group by side and count steps
//     final groupedData = groupBy(sensorData, (SensorData data ) => data.side);
//     final leftSteps = groupedData['L'] != null ? countPeaks(groupedData['L']!.map((data) => data.accMagnitude).toList(), meanHeight, minDistance) : 0;
//     final rightSteps = groupedData['R'] != null ? countPeaks(groupedData['R']!.map((data) => data.accMagnitude).toList(), meanHeight, minDistance) : 0;

//     return {'left_steps': [leftSteps], 'right_steps': [rightSteps]};
//   }

//   static double _calculateMean(List<double> values) {
//     return values.reduce((a, b) => a + b) / values.length;
//   }

//   static double _calculateStd(List<double> values) {
//     final mean = _calculateMean(values);
//     final variance = values.map((value) => (value - mean) * (value - mean)).reduce((a, b) => a + b) / values.length;
//     return sqrt(variance);
//   }

//   static double _calculateMedian(List<double> values) {
//     values.sort();
//     final mid = values.length ~/ 2;
//     if (values.length % 2 == 1) {
//       return values[mid];
//     } else {
//       return (values[mid - 1] + values[mid]) / 2.0;
//     }
//   }
// }


