import 'z_screen_imports.dart';

class MeasurementDetailScreen extends StatefulWidget {
  final Measurement measurement;

  const MeasurementDetailScreen({super.key, required this.measurement});

  @override
  // ignore: library_private_types_in_public_api
  _MeasurementDetailScreenState createState() => _MeasurementDetailScreenState();
}

class _MeasurementDetailScreenState extends State<MeasurementDetailScreen> {
  String selectedSensorType = 'Step Count';
  int selectedDataPoints = 25;
  List<SensorData> sensorData = [];

  @override
  void initState() {
    super.initState();
    fetchSensorData();
  }

  Future<void> fetchSensorData() async {
    final String response = await rootBundle.loadString('assets/data/input_data.json');
    final List<dynamic> data = json.decode(response);

    setState(() {
      sensorData = data
          .map((entry) => SensorData.fromJson(entry))
          .where((sensorData) => sensorData.id == widget.measurement.id)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (sensorData.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Measurement Details')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // sensor keys
    List<String> sensorKeys =
        selectedSensorType == 'Accelerometer' ? ['ax', 'ay', 'az'] : ['gx', 'gy', 'gz'];

    // Downsample sensor data for all three selected axes
    List<List<FlSpot>> downsampledSeries =
        sensorKeys.map((key) => downsampleData(sensorData, key, selectedDataPoints)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Measurement Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedSensorType,
                  items: ['Step Count', 'Accelerometer', 'Gyroscope']
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSensorType = value!;
                    });
                  },
                ),
               Row(children: [
                const Text('Zoom: '),
                 DropdownButton<int>(
                  value: selectedDataPoints,
                  items: [15, 20, 25, 30]
                      .map((points) =>
                          DropdownMenuItem(value: points, child: Text(points.toString())))
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedDataPoints = value!);
                  },
                ),
               ],)
              ],
            ),
            const SizedBox(height: 20),

            // Line Chart
            SizedBox(
              height: 280,
              width: double.infinity, 
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: selectedSensorType == 'Step Count'
                      ? [
                          LineChartBarData(
                            spots: downsampleStepCounts(sensorData, selectedDataPoints)[0],
                            isCurved: true,
                            color: Colors.orange, 
                          ),
                        ]
                      : [
                          for (int i = 0; i < 3; i++)
                            LineChartBarData(
                              spots: downsampledSeries[i],
                              isCurved: true,
                              color: [Colors.blue, Colors.green, Colors.red][i],
                            ),
                        ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Measurement Summary
            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: const {
                0: FlexColumnWidth(2), // First column (Label)
                1: FlexColumnWidth(3), // Second column (Value)
              },
              children: [
                _buildTableRow('ID', widget.measurement.id),
                _buildTableRow('Start Time', widget.measurement.formattedStartTime),
                _buildTableRow('End Time', widget.measurement.formattedEndTime),
                _buildTableRow('Duration', widget.measurement.formattedDuration),
                _buildTableRow('Left Steps', widget.measurement.leftSteps.toString()),
                _buildTableRow('Right Steps', widget.measurement.rightSteps.toString()),
                _buildTableRow('Number of Readings', sensorData.length.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a table row
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Palette.dataTableText)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, style: const TextStyle(fontSize: 14, color: Palette.dataTableText),),
        ),
      ],
    );
  }
}
