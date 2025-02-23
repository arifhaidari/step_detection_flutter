import 'z_widgets_imports.dart';
import 'package:intl/intl.dart';

class PredictionGraph extends StatefulWidget {
  @override
  _PredictionGraphState createState() => _PredictionGraphState();
}

class _PredictionGraphState extends State<PredictionGraph> {
  late Future<List<Measurement>> _measurements;

  @override
  void initState() {
    super.initState();
    _measurements = DataProvider().getMeasurements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bar & Line Chart")),
      body: FutureBuilder<List<Measurement>>(
        future: _measurements,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No data available"));
          }

          // final data = snapshot.data!;
          // sorting values based on startTime
          final data = snapshot.data!..sort((a, b) => a.startTime.compareTo(b.startTime));

          return Column(
            children: [
              Container(
                height: 280,
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      StepBarChart(measurements: data),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 35),
                        // padding: const EdgeInsets.all(16.0),
                        child: StepLineChart(measurements: data, isLeftSteps: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 35),
                        child: StepLineChart(measurements: data, isLeftSteps: false),
                      ),
                      // Positioned.fill(child: StepLineChart(measurements: data, isLeftSteps: true)),
                      // Positioned.fill(child: StepLineChart(measurements: data, isLeftSteps: false)),
                      Positioned(
                        top: 0,
                        left: 35,
                        child: StepLegend(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class StepLineChart extends StatelessWidget {
  final List<Measurement> measurements;
  final bool isLeftSteps;

  StepLineChart({required this.measurements, required this.isLeftSteps});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: measurements.asMap().entries.map((entry) {
              int index = entry.key;
              double yValue = isLeftSteps
                  ? entry.value.leftSteps.toDouble()
                  : entry.value.rightSteps.toDouble();
              return FlSpot(index.toDouble(), yValue);
            }).toList(),
            isCurved: true,
            barWidth: 2,
            color: isLeftSteps ? Colors.blue[200] : Colors.grey[200],
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

class StepBarChart extends StatelessWidget {
  final List<Measurement> measurements;

  StepBarChart({required this.measurements});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: measurements.asMap().entries.map((entry) {
          int index = entry.key;
          Measurement measurement = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                borderRadius: BorderRadius.circular(3),
                toY: measurement.leftSteps.toDouble(),
                color: Colors.blue,
                width: 20,
              ),
              BarChartRodData(
                borderRadius: BorderRadius.circular(3),
                toY: measurement.rightSteps.toDouble(),
                color: Colors.grey,
                width: 20,
              ),
            ],
          );
        }).toList(),
        groupsSpace: 12,
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              // reservedSize: 0,
              getTitlesWidget: (value, meta) {
                return Text(value.toString(), style: const TextStyle(fontSize: 12, 
                        color: Palette.dataTableText,));
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= measurements.length) return SizedBox();
                Measurement measurement = measurements[value.toInt()];
                String formattedTime =
                    "${DateFormat('mm:ss').format(measurement.startTime)} - ${DateFormat('mm:ss').format(measurement.endTime)}";
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Transform.rotate(
                    angle: -0.45,
                    child: Text(formattedTime,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Palette.dataTableText,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        gridData: FlGridData(show: true),
      ),
    );
  }
}

class StepLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _LegendItem(color: Colors.blue, text: "Left"),
          SizedBox(width: 10),
          _LegendItem(color: Colors.grey, text: "Right"),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3))),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 14, color: Palette.dataTableText)),
      ],
    );
  }
}
