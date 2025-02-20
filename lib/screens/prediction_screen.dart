import 'z_screen_imports.dart';

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  Future<List<Measurement>>? _futureMeasurements;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prediction")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_futureMeasurements == null)
                  const Icon(Icons.cloud_upload, size: 80, color: Colors.blueAccent),
                const SizedBox(height: 15),
                FutureBuilder<List<Measurement>>(
                  future: _futureMeasurements,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.red));
                    } else if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final measurement = snapshot.data![index];
                            return Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Text(
                                  "ID: ${measurement.id}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                    "Start: ${measurement.startTime}\nEnd: ${measurement.endTime}\nLeft Steps: ${measurement.leftSteps}\nRight Steps: ${measurement.rightSteps}",
                                    style: const TextStyle(
                                        fontSize: 15, color: Palette.dataTableText)),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Text("No data available",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
                    }
                  },
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _futureMeasurements = ApiService().uploadPredictions();
                });
              },
              child: const Text("Choose File", style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
