import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:step_detection_flutter/data/sensor_data_model.dart';
import 'package:step_detection_flutter/utils/json_loader.dart';

class SensorDataTable extends StatefulWidget {
  @override
  _SensorDataTableState createState() => _SensorDataTableState();
}

class _SensorDataTableState extends State<SensorDataTable> {
  // List<PlutoColumn> columns = [];
  // List<PlutoRow> rows = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sensor Data Table')),
      body: FutureBuilder<List<SensorData>>(
        future: JsonLoader.loadSensorData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          List<SensorData> sensorDataList = snapshot.data!;
          List<PlutoRow> loadedRows = sensorDataList.map((sensor) {
            return PlutoRow(cells: {
              'id': PlutoCell(value: sensor.id),
              'side': PlutoCell(value: sensor.side),
              'ax': PlutoCell(value: sensor.ax.toStringAsFixed(3)),
              'ay': PlutoCell(value: sensor.ay.toStringAsFixed(3)),
              'az': PlutoCell(value: sensor.az.toStringAsFixed(3)),
              'gx': PlutoCell(value: sensor.gx.toStringAsFixed(3)),
              'gy': PlutoCell(value: sensor.gy.toStringAsFixed(3)),
              'gz': PlutoCell(value: sensor.gz.toStringAsFixed(3)),
              'time': PlutoCell(value: sensor.formattedTime),
              'time_diff': PlutoCell(value: sensor.timeDiff.toStringAsFixed(3)),
            });
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlutoGrid(
              columns: [
                PlutoColumn(title: 'ID', field: 'id', type: PlutoColumnType.text(), width: 100),
                PlutoColumn(title: 'Side', field: 'side', type: PlutoColumnType.text(), width: 70),
                PlutoColumn(
                    title: 'Ax',
                    field: 'ax',
                    type: PlutoColumnType.number(format: '#,##0.000'),
                    width: 80),
                PlutoColumn(
                    title: 'Ay',
                    field: 'ay',
                    type: PlutoColumnType.number(format: '#,##0.000'),
                    width: 80),
                PlutoColumn(
                    title: 'Az',
                    field: 'az',
                    type: PlutoColumnType.number(format: '#,##0.000'),
                    width: 80),
                PlutoColumn(
                    title: 'Gx',
                    field: 'gx',
                    type: PlutoColumnType.number(format: '#,##0.000'),
                    width: 80),
                PlutoColumn(
                    title: 'Gy',
                    field: 'gy',
                    type: PlutoColumnType.number(format: '#,##0.000'),
                    width: 80),
                PlutoColumn(
                    title: 'Gz',
                    field: 'gz',
                    type: PlutoColumnType.number(format: '#,##0.000'),
                    width: 80),
                PlutoColumn(title: 'Time', field: 'time', type: PlutoColumnType.text(), width: 190),
                PlutoColumn(
                    title: 'Time Diff (ms)',
                    field: 'time_diff',
                    type: PlutoColumnType.number(format: '#,##0.000'),
                    width: 130),
              ],
              rows: loadedRows,
              onLoaded: (PlutoGridOnLoadedEvent event) {},
              onChanged: (PlutoGridOnChangedEvent event) {},
              configuration: PlutoGridConfiguration(
    style: PlutoGridStyleConfig(
      // Background Color
      gridBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      
      // Table Borders
      borderColor: Theme.of(context).dividerColor, 
      
      // Row Color
      rowColor: Theme.of(context).cardColor,
      activatedColor: Colors.black,
      menuBackgroundColor: Colors.black,
      
      // Column and Cell Text Color
      columnTextStyle: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
      cellTextStyle: const TextStyle(color: Colors.lightGreenAccent),
      iconColor: Colors.lightGreenAccent,
    ),
  ),
            ),
          );
        },
      ),
    );
  }
}
