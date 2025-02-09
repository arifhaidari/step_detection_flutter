import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../data/measurement_model.dart';
import '../data/sensor_data_model.dart';

class JsonLoader {
  static Future<List<Measurement>> loadMeasurements() async {
    final String response = await rootBundle.loadString('assets/data/calculated_steps.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Measurement.fromJson(json)).toList();
  }

  static Future<List<SensorData>> loadSensorData() async {
    final String response = await rootBundle.loadString('assets/data/input_data.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => SensorData.fromJson(json)).toList();
  }
}
