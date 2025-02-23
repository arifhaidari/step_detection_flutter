import 'z_screen_imports.dart';

class CombinedAnalysisScreen extends StatefulWidget {
  const CombinedAnalysisScreen({super.key});

  @override
  _CombinedAnalysisScreenState createState() => _CombinedAnalysisScreenState();
}

class _CombinedAnalysisScreenState extends State<CombinedAnalysisScreen> {
  late Future<List<Measurement>> _measurements;

  @override
  void initState() {
    super.initState();
    _measurements = DataProvider().getMeasurements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analysis Overview")),
      body: FutureBuilder<List<Measurement>>(
        future: _measurements,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          final data = snapshot.data!..sort((a, b) => a.startTime.compareTo(b.startTime));
          final GaitAnalysis analysis = GaitAnalysis(data);

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 280,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(
                    children: [
                      StepBarChart(measurements: data),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 35),
                        child: StepLineChart(measurements: data, isLeftSteps: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 35),
                        child: StepLineChart(measurements: data, isLeftSteps: false),
                      ),
                      Positioned(
                        top: 0,
                        left: 35,
                        child: StepLegend(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildInfoCard("Total Duration", "${analysis.totalSessionDuration.toStringAsFixed(2)} seconds"),
                      _buildInfoCard("Total Steps", "Left: ${analysis.totalLeftSteps} - Right: ${analysis.totalRightSteps}"),
                      _buildInfoCard("Fastest Session", analysis.fastestSession != null ? "${analysis.fastestSession!.onlyTimeStartTime} - ${analysis.fastestSession!.onlyTimeEndTime}" : "No data"),
                      _buildInfoCard("Slowest Session", analysis.slowestSession != null ? "${analysis.slowestSession!.onlyTimeStartTime} - ${analysis.slowestSession!.onlyTimeEndTime}" : "No data"),
                      _buildInfoCard("Total Running Time", analysis.runningStatusMessage),
                      _buildInfoCard("Periods of Inactivity", analysis.inactivePeriods.isNotEmpty ? "${analysis.inactivePeriods.length} sessions" : "None"),
                      _buildInfoCard("Time Interval", "${analysis.startTime} - ${analysis.endTime}"),
                      // _buildAdditionalInsights(analysis.additionalInsights, "Additional Insights"),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      // elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(color: Palette.dataTableText, fontSize: 16),),
      ),
    );
  }

  Widget _buildAdditionalInsights(List<String> insights, String title) {
    return Card(
      // elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ...insights.map((insight) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text("- $insight"),
                )),
          ],
        ),
      ),
    );
  }
}
