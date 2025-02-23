import 'z_screen_imports.dart';

class MeasurementListScreen extends StatefulWidget {


  MeasurementListScreen({super.key});

  @override
  State<MeasurementListScreen> createState() => _MeasurementListScreenState();
}

class _MeasurementListScreenState extends State<MeasurementListScreen> {
  List<Measurement> exportPrediction = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measurements'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              // Show export options
              if (value == 'export_json') {
                exportData('json', exportPrediction).then((value) {
                  if (value) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Exported to JSON')));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Canceled')));
                  }
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Exporting to JSON...')));
              } else if (value == 'export_csv') {
                exportData('csv', exportPrediction).then((value) {
                  if (value) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Exported to CSV')));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Canceled')));
                  }
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Exporting to CSV...')));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'export_json',
                  child: Text('Export to JSON'),
                ),
                const PopupMenuItem<String>(
                  value: 'export_csv',
                  child: Text('Export to CSV'),
                ),
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Measurement>>(
        future: DataProvider().getMeasurements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No measurements available.'));
          } else {
            final measurements = snapshot.data!;
            exportPrediction = measurements;
            return ListView.builder(
              itemCount: measurements.length,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              itemBuilder: (context, index) {
                final measurement = measurements[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeasurementDetailScreen(
                            measurement: measurement,
                          ),
                        ),
                      );
                    },
                    title: Text(
                      measurement.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Start: ${measurement.formattedStartTime}\nEnd: ${measurement.formattedEndTime}',
                        style: const TextStyle(fontSize: 15, color: Palette.dataTableText),
                      ),
                    ),
                    trailing: SizedBox(
                      width: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.directions_walk, color: Colors.green, size: 20),
                              const SizedBox(width: 5),
                              Text(
                                'Left: ${measurement.leftSteps}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.directions_walk, color: Colors.blue, size: 20),
                              const SizedBox(width: 5),
                              Text(
                                'Right: ${measurement.rightSteps}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
