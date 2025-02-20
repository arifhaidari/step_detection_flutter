import 'z_providers_imports.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: BASE_URL));

  // POST: Upload JSON files from mobile storage
  Future<List<Measurement>> uploadPredictions() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        List<MultipartFile> files = [];
        for (var file in result.files) {
          files.add(await MultipartFile.fromFile(file.path!, filename: file.name));
        }
        FormData formData = FormData.fromMap({"files": files});
        final response = await _dio.post('/predict-db', data: formData);
        List<dynamic> responseData = response.data;
        return responseData.map((json) => Measurement.fromJson(json)).toList();
      } else {
        throw Exception('No file selected');
      }
    } catch (e) {
      throw Exception('Failed to upload predictions: $e');
    }
  }

  // GET: Retrieve all predictions
  Future<List<Measurement>> getPredictions() async {
    try {
      final response = await _dio.get('/predictions');
      List<dynamic> responseData = response.data;
      return responseData.map((json) => Measurement.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch predictions: $e');
    }
  }

  // GET: Get details of a prediction by ID
  Future<Measurement> getPredictionDetail(String id) async {
    try {
      final response = await _dio.get('/predictions/detail/$id');
      return Measurement.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch prediction details: $e');
    }
  }

  // DELETE: Delete a prediction by ID
  Future<String> deletePrediction(String id) async {
    try {
      final response = await _dio.delete('/predictions/$id');
      return response.data['message'];
    } catch (e) {
      throw Exception('Failed to delete prediction: $e');
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (_) {
      return false;
    }
    return false;
  }

  Future<bool> checkApiStatus() async {
    final dio = Dio();
    const String apiUrl = 'http://10.0.2.2:8000/'; // Change if needed

    try {
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
