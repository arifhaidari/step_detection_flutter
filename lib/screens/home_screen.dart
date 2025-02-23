import 'z_screen_imports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void showNotImplementedToast(BuildContext context) {
    const snackBar = SnackBar(
      content: Text("API is not up and running!!!"),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.activity, size: 28, color: Colors.blueAccent),
                SizedBox(width: 10),
                Icon(Icons.directions_walk, size: 28, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  "Step Detection",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Palette.dataTableText,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.directions_walk, size: 28, color: Colors.green),
                SizedBox(width: 10),
                Icon(LucideIcons.activity, size: 28, color: Colors.blueAccent),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.4,
                children: [
                  _buildSquareButton(context, LucideIcons.fileJson, "JSON File", () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => MeasurementListScreen()));
                  }),
                  _buildSquareButton(context, LucideIcons.table, "Sensor Data", () {
                  
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const SensorDataTable()));
                  }),
                  _buildSquareButton(context, LucideIcons.barChartBig, "Analysis", () async {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const CombinedAnalysisScreen()));
                  }),
                  _buildSquareButton(context, LucideIcons.brain, "Prediction", () async {
                    if (await ApiService().checkApiStatus()) {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => PredictionScreen()));
                    } else {
                      showNotImplementedToast(context);
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueAccent, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blueAccent),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Palette.dataTableText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
