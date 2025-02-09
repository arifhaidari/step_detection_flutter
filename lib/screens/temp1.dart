// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // For loading JSON from assets
// import 'package:fl_chart/fl_chart.dart'; // For the chart
// import 'package:step_detection_flutter/widgets/step_count_bar.dart';
// import 'dart:convert'; // For JSON decoding
// import '../data/measurement_model.dart';
// import '../data/sensor_data_model.dart';
// import '../utils/down_sampling_sensor_data.dart';
// import '../widgets/step_count_bar.dart';

// class MeasurementDetailScreen extends StatefulWidget {
//   final Measurement measurement;

//   MeasurementDetailScreen({required this.measurement});

//   @override
//   _MeasurementDetailScreenState createState() => _MeasurementDetailScreenState();
// }

// class _MeasurementDetailScreenState extends State<MeasurementDetailScreen> {
//   String selectedSensorType = 'Accelerometer';
//   int selectedDataPoints = 25;
//   List<SensorData> sensorData = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchSensorData();
//   }

//   Future<void> fetchSensorData() async {
//     final String response = await rootBundle.loadString('assets/data/input_data.json');
//     final List<dynamic> data = json.decode(response);

//     setState(() {
//       sensorData = data
//           .map((entry) => SensorData.fromJson(entry))
//           .where((sensorData) => sensorData.id == widget.measurement.id)
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (sensorData.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(title: Text('Measurement Details')),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     // Determine sensor keys
//     List<String> sensorKeys =
//         selectedSensorType == 'Accelerometer' ? ['ax', 'ay', 'az'] : ['gx', 'gy', 'gz'];

//     // Downsample sensor data for all three selected axes
//     List<List<FlSpot>> downsampledSeries =
//         sensorKeys.map((key) => downsampleData(sensorData, key, selectedDataPoints)).toList();

//     return Scaffold(
//       appBar: AppBar(title: Text('Measurement Details')),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Dropdown Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 DropdownButton<String>(
//                   value: selectedSensorType,
//                   items: ['Accelerometer', 'Gyroscope']
//                       .map((type) => DropdownMenuItem(value: type, child: Text(type)))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() => selectedSensorType = value!);
//                   },
//                 ),
//                 DropdownButton<int>(
//                   value: selectedDataPoints,
//                   items: [15, 20, 25, 30]
//                       .map((points) =>
//                           DropdownMenuItem(value: points, child: Text(points.toString())))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() => selectedDataPoints = value!);
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),

//             // Line Chart
//             SizedBox(
//               height: 300,
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(show: true),
//                   titlesData: FlTitlesData(show: true),
//                   borderData: FlBorderData(show: true),
//                   lineBarsData: [
//                     for (int i = 0; i < 3; i++)
//                       LineChartBarData(
//                         spots: downsampledSeries[i],
//                         isCurved: true,
//                         color: [Colors.blue, Colors.green, Colors.red][i],
//                       ),
//                   ],
//                 ),
//               ),
//             ),

//             SizedBox(height: 16),

//             // Measurement Summary
//             Table(
//               border: TableBorder.all(color: Colors.grey),
//               columnWidths: const {
//                 0: FlexColumnWidth(2), // First column (Label)
//                 1: FlexColumnWidth(3), // Second column (Value)
//               },
//               children: [
//                 _buildTableRow('ID', widget.measurement.id),
//                 _buildTableRow('Start Time', widget.measurement.formattedStartTime),
//                 _buildTableRow('End Time', widget.measurement.formattedEndTime),
//                 _buildTableRow('Duration', widget.measurement.formattedDuration),
//                 _buildTableRow('Left Steps', widget.measurement.leftSteps.toString()),
//                 _buildTableRow('Right Steps', widget.measurement.rightSteps.toString()),
//                 _buildTableRow('Number of Readings', sensorData.length.toString()),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper method to create a table row
//   TableRow _buildTableRow(String label, String value) {
//     return TableRow(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(value),
//         ),
//       ],
//     );
//   }
// }
