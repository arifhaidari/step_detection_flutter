import 'z_widgets_imports.dart';


List<FlSpot> downsampleData(List<SensorData> data, String sensorColumn, int numberOfPoints) {
  final int dataSize = data.length;
  final int segmentSize = (dataSize / numberOfPoints).ceil();  // Divide into dynamic segments
  
  List<FlSpot> downsampledData = [];
  
  // Iterate to divide the data into the specified number of points
  for (int i = 0; i < numberOfPoints; i++) {
    final startIndex = i * segmentSize;
    final endIndex = (i + 1) * segmentSize < dataSize ? (i + 1) * segmentSize : dataSize;
    final segment = data.sublist(startIndex, endIndex);
    
    // Calculate the average sensor value for the chosen column dynamically
    double averageSensorValue = 0;
    double averageTime = 0;
    
    for (var sensor in segment) {
      // Dynamically access the sensor data property using reflection
      averageSensorValue += _getSensorColumnValue(sensor, sensorColumn);
      averageTime += sensor.time.millisecondsSinceEpoch.toDouble();  // Average the time
    }
    
    averageSensorValue /= segment.length;
    averageTime /= segment.length;
    
    // Add the average time and average sensor value as a data point
    downsampledData.add(FlSpot(averageTime, averageSensorValue));
  }
  
  return downsampledData;
}

// Helper function to dynamically access the sensor column value
double _getSensorColumnValue(SensorData sensor, String sensorColumn) {
  switch (sensorColumn) {
    case 'ax':
      return sensor.ax;
    case 'ay':
      return sensor.ay;
    case 'az':
      return sensor.az;
    case 'gx':
      return sensor.gx;
    case 'gy':
      return sensor.gy;
    case 'gz':
      return sensor.gz;
    default:
      throw ArgumentError('Invalid sensor column: $sensorColumn');
  }
}
