import 'z_providers_imports.dart';

class DataProvider {
  Future<List<Measurement>> getMeasurements() async {
    return await JsonLoader.loadMeasurements();
  }

  Future<List<SensorData>> getSensorData() async {
    return await JsonLoader.loadSensorData();
  }
}
