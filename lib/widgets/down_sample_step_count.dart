import 'z_widgets_imports.dart';

List<List<FlSpot>> downsampleStepCounts(List<SensorData> data, int numberOfPoints) {
    final int dataSize = data.length;
    final int segmentSize = (dataSize / numberOfPoints).ceil();

    List<FlSpot> downsampledSteps = [];

    for (int i = 0; i < numberOfPoints; i++) {
      final startIndex = i * segmentSize;
      final endIndex = (i + 1) * segmentSize < dataSize ? (i + 1) * segmentSize : dataSize;
      final segment = data.sublist(startIndex, endIndex);

      // Count steps in this segment
      int stepCount = countSteps(segment);

      // Calculate the average time of the segment
      double averageTime = segment
              .map((sensor) => sensor.time.millisecondsSinceEpoch.toDouble())
              .reduce((a, b) => a + b) /
          segment.length;

      downsampledSteps.add(FlSpot(averageTime, stepCount.toDouble()));
    }

    return [downsampledSteps]; // Return a list with a single series of downsampled steps
  }
