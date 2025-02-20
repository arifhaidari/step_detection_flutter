import 'z_utils_imports.dart';

Future<bool> exportData(String format, List<Measurement> predictions) async {
  // ask for permission:
  var status = await Permission.manageExternalStorage.request();
  if (!status.isGranted) {
    // print('permission granted ===----===');
  }

  var status_storage = await Permission.storage.request();
  if (!status_storage.isGranted) {
    // print("Storage permission denied");
    // return;
  }

  // Prepare data for export
  List<Map<String, dynamic>> dataToExport = predictions.map((prediction) {
    return {
      'id': prediction.id,
      'left_steps': prediction.leftSteps,
      'right_steps': prediction.rightSteps,
      'start_time': prediction.startTime.toIso8601String(), // Convert to String
      'end_time': prediction.endTime.toIso8601String(), 
      'timestamp': prediction.timestamp,
    };
  }).toList();


  String fileContent = '';

  if (format == 'json') {
    // Convert data to JSON string
    fileContent = jsonEncode(dataToExport);
  } else if (format == 'csv') {
    // Convert data to CSV string
    List<String> headers = [
      'id',
      'left_steps',
      'right_steps',
      'start_time',
      'end_time',
      'timestamp'
    ];
    List<String> rows = [headers.join(',')];
    for (var record in dataToExport) {
      rows.add(headers.map((header) => record[header]?.toString() ?? '').join(','));
    }
    fileContent = rows.join('\n');
  }

  // Use File Picker to select a save location
  String? directoryPath = await FilePicker.platform.getDirectoryPath();
  if (directoryPath != null) {
    // Generate a random unique file name
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    // String randomNum = Random().nextInt(10000).toString(); // Random 4-digit number
    String fileName = "predictions_$timestamp";

    final file = File('$directoryPath/$fileName.$format');
    await file.writeAsString(fileContent); 
    return true;
  } else {
    return false;
  }

// this method stores the data to app storage 
  // try {
  //   // Get the app's documents directory
  //   Directory? directory = await getExternalStorageDirectory(); // Internal storage
  //   if (directory == null) {
  //     print("Error: No external storage directory available");
  //     // return;
  //   }

  //   // Define the file path
  //   String filePath = '${directory?.path}/predictions121233.json';

  //   // Write data to the file
  //   File file = File(filePath);
  //   await file.writeAsString(fileContent);

  //   print("File saved at: $filePath");
  //   return true;
  // } catch (e) {
  //   print("Error writing file: $e");
  //   return false;
  // }

}
