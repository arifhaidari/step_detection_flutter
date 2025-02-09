// import 'package:flutter/material.dart';
// import 'package:data_table_2/data_table_2.dart';
// import 'package:step_detection_flutter/data/data_provider.dart';
// import 'package:step_detection_flutter/data/sensor_data_model.dart';

// class SensorDataScreen extends StatefulWidget {
//   @override
//   _SensorDataScreenState createState() => _SensorDataScreenState();
// }

// class _SensorDataScreenState extends State<SensorDataScreen> {
//   late Future<List<SensorData>> futureSensorData;
//   final DataProvider dataProvider = DataProvider();

//   @override
//   void initState() {
//     super.initState();
//     futureSensorData = dataProvider.getSensorData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sensor Data Table'),
//       ),
//       body: FutureBuilder<List<SensorData>>(
//         future: futureSensorData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No data available'));
//           } else {
//             return SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable2(
//                   columnSpacing: 12,
//                   horizontalMargin: 12,
//                   minWidth: 600,
//                   columns: [
//                     DataColumn(label: Text('Time')),
//                     DataColumn(label: Text('AX')),
//                     DataColumn(label: Text('AY')),
//                     DataColumn(label: Text('AZ')),
//                     DataColumn(label: Text('GX')),
//                     DataColumn(label: Text('GY')),
//                     DataColumn(label: Text('GZ')),
//                     DataColumn(label: Text('ID')),
//                     DataColumn(label: Text('Side')),
//                     DataColumn(label: Text('Time Diff')),
//                   ],
//                   rows: snapshot.data!.map((sensorData) {
//                     return DataRow(
//                       cells: [
//                         DataCell(Text(sensorData.time.toString())),
//                         DataCell(Text(sensorData.ax.toString())),
//                         DataCell(Text(sensorData.ay.toString())),
//                         DataCell(Text(sensorData.az.toString())),
//                         DataCell(Text(sensorData.gx.toString())),
//                         DataCell(Text(sensorData.gy.toString())),
//                         DataCell(Text(sensorData.gz.toString())),
//                         DataCell(Text(sensorData.id)),
//                         DataCell(Text(sensorData.side)),
//                         DataCell(Text(sensorData.timeDiff.toString())),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
