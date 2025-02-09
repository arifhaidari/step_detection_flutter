import 'dart:math';
import 'package:step_detection_flutter/data/sensor_data_model.dart';

// Function to calculate mean and standard deviation
double calculateMean(List<double> values) {
  double sum = values.reduce((a, b) => a + b);
  return sum / values.length;
}

double calculateStdDev(List<double> values, double mean) {
  double sum = values.fold(0, (prev, curr) => prev + pow(curr - mean, 2).toDouble());
  return sqrt(sum / values.length);
}

// Function to find peaks in the sensor data
List<int> findPeaks(List<double> series, double threshold) {
  List<int> peaks = [];
  
  for (int i = 1; i < series.length - 1; i++) {
    if (series[i] > threshold && series[i] > series[i - 1] && series[i] > series[i + 1]) {
      peaks.add(i); // Peak detected
    }
  }
  
  return peaks;
}

// Function to count steps based on az values
int countSteps(List<SensorData> data) {
  List<double> azValues = data.map((sensor) => sensor.az).toList();
  
  double meanAz = calculateMean(azValues);
  double stdAz = calculateStdDev(azValues, meanAz);
  double threshold = meanAz + 0.25 * stdAz; // Threshold based on Data Science Project
  
  List<int> peaks = findPeaks(azValues, threshold);
  
  return peaks.length;
}
