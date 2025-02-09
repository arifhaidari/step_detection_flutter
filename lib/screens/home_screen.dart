import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:step_detection_flutter/screens/measurement_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void showNotImplementedToast(BuildContext context) {
    const snackBar = SnackBar(
      content: Text("This feature is not implemented yet!"),
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
            const Icon(
              LucideIcons.activity,
              size: 100,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              "Step Detection",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            _buildButton(
              context,
              icon: LucideIcons.fileJson,
              label: "JSON File",
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MeasurementListScreen()));
              },
            ),
            //  const SizedBox(height: 20),
            // _buildButton(
            //   context,
            //   icon: LucideIcons.server,
            //   label: "Raw Data",
            //   onPressed: () {
            //     // Navigator.push(context, MaterialPageRoute(builder: (context) => SensorDataScreen()));
            //   },
            // ),
            const SizedBox(height: 20),
            _buildButton(
              context,
              icon: LucideIcons.server,
              label: "Server API",
              onPressed: () => showNotImplementedToast(context),
            ),
            const SizedBox(height: 20),
            _buildButton(
              context,
              icon: LucideIcons.brain,
              label: "Prediction",
              onPressed: () => showNotImplementedToast(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        primary: Colors.blueAccent,
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 24, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
