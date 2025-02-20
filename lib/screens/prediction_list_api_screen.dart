import 'z_screen_imports.dart';

class PredictionTableScreen extends StatefulWidget {
  const PredictionTableScreen({super.key});

  @override
  _PredictionTableScreenState createState() => _PredictionTableScreenState();
}

class _PredictionTableScreenState extends State<PredictionTableScreen> {
  List<Measurement> exportPrediction = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predictions'),
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
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Canceled')));
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
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Canceled')));
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
        future: ApiService().getPredictions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No predictions available'));
          }

          List<Measurement> predictions = snapshot.data!;
          exportPrediction = predictions;
          List<PlutoRow> loadedRows = predictions.map((prediction) {
            return PlutoRow(cells: {
              'id': PlutoCell(value: prediction.id),
              'left_steps': PlutoCell(value: prediction.leftSteps.toString()),
              'right_steps': PlutoCell(value: prediction.rightSteps.toString()),
              'start_time': PlutoCell(value: prediction.startTime),
              'end_time': PlutoCell(value: prediction.endTime),
              'timestamp': PlutoCell(value: prediction.timestamp),
            });
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlutoGrid(
              columns: [
                PlutoColumn(title: 'ID', field: 'id', type: PlutoColumnType.text(), width: 100),
                PlutoColumn(
                    title: 'Start Time',
                    field: 'start_time',
                    type: PlutoColumnType.text(),
                    width: 150),
                PlutoColumn(
                    title: 'End Time', field: 'end_time', type: PlutoColumnType.text(), width: 150),
                PlutoColumn(
                    title: 'Left Steps',
                    field: 'left_steps',
                    type: PlutoColumnType.number(),
                    width: 120),
                PlutoColumn(
                    title: 'Right Steps',
                    field: 'right_steps',
                    type: PlutoColumnType.number(),
                    width: 120),
                PlutoColumn(
                    title: 'Timestamp',
                    field: 'timestamp',
                    type: PlutoColumnType.text(),
                    width: 190),
              ],
              rows: loadedRows,
              onLoaded: (PlutoGridOnLoadedEvent event) {},
              onChanged: (PlutoGridOnChangedEvent event) {},
              configuration: PlutoGridConfiguration(
                style: PlutoGridStyleConfig(
                  gridBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  borderColor: Theme.of(context).dividerColor,
                  rowColor: Theme.of(context).cardColor,
                  activatedColor: Colors.black,
                  menuBackgroundColor: Colors.black,
                  columnTextStyle: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                  cellTextStyle: const TextStyle(color: Palette.dataTableText),
                  iconColor: Palette.dataTableText,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
