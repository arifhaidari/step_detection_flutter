import 'package:flutter/material.dart';
import '../data/data_provider.dart';
import '../data/measurement_model.dart';
import '../screens/measurement_detail_screen.dart'; // Screen for showing measurement details

class MeasurementListScreen extends StatelessWidget {
  final DataProvider dataProvider = DataProvider();

  Future<List<Measurement>> fetchMeasurements() async {
    return await dataProvider.getMeasurements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measurements'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Measurement>>(
        future: fetchMeasurements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No measurements available.'));
          } else {
            final measurements = snapshot.data!;
            return ListView.builder(
              itemCount: measurements.length,
              itemBuilder: (context, index) {
                final measurement = measurements[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      // Navigate to the details screen when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeasurementDetailScreen(
                            measurement: measurement,
                          ),
                        ),
                      );
                    },
                    // leading: CircleAvatar(
                    //   backgroundColor: Colors.teal,
                    //   child: Icon(Icons.history, color: Colors.white),
                    // ),
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
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    trailing: SizedBox(
                      width: 120, // Set a fixed width for trailing
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.directions_walk, color: Colors.green, size: 18),
                              SizedBox(width: 5),
                              Text('Left: ${measurement.leftSteps}'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.directions_walk, color: Colors.blue, size: 18),
                              SizedBox(width: 5),
                              Text('Right: ${measurement.rightSteps}'),
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
