import '../utils/json_loader.dart';
import '../data/measurement_model.dart';
import '../data/sensor_data_model.dart';

class DataProvider {
  Future<List<Measurement>> getMeasurements() async {
    return await JsonLoader.loadMeasurements();
  }

  Future<List<SensorData>> getSensorData() async {
    return await JsonLoader.loadSensorData();
  }
}
