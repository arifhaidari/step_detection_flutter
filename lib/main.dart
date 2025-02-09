import 'package:flutter/material.dart';
import 'package:step_detection_flutter/screens/home_screen.dart';

void main() {
  runApp(StepDetectionApp());
}

class StepDetectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const HomeScreen(),
    );
  }
}
