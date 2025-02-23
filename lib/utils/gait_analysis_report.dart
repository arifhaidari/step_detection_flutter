import 'z_utils_imports.dart';

class GaitAnalysis {
  final List<Measurement> measurements;

  GaitAnalysis(this.measurements);

  // Total duration of running 
  // (assuming running means session > 10s)
  // double get totalRunningTime {
  //   return measurements
  //       .where((m) => m.sessionDuration > 10)
  //       .fold(0, (sum, m) => sum + m.sessionDuration);
  // }
  double get totalRunningTime {
    return runningSessions.isNotEmpty
        ? runningSessions.fold(0, (sum, m) => sum + m.sessionDuration)
        : 0;
  }

  // Running status message
  String get runningStatusMessage {
    return runningSessions.isNotEmpty
        ? "Total Running Time: ${totalRunningTime.toStringAsFixed(2)} seconds"
        : "No running during walk (only normal walk)";
  }

  // Total duration of all sessions
  double get totalSessionDuration {
    return measurements.fold(0, (sum, m) => sum + m.sessionDuration);
  }

  // Running sessions (steps > 2x duration)
  List<Measurement> get runningSessions {
    return measurements.where((m) => (m.leftSteps + m.rightSteps) > (2 * m.sessionDuration)).toList();
  }

  // Total left and right steps
  int get totalLeftSteps =>
      measurements.fold(0, (sum, m) => sum + m.leftSteps);
  int get totalRightSteps =>
      measurements.fold(0, (sum, m) => sum + m.rightSteps);

  // Find the fastest session (max steps per second)
  Measurement? get fastestSession {
    return measurements.isNotEmpty
        ? measurements.reduce((a, b) =>
            (a.leftSteps + a.rightSteps) / a.sessionDuration >
                    (b.leftSteps + b.rightSteps) / b.sessionDuration
                ? a
                : b)
        : null;
  }

  // Find the slowest session (min steps per second)
  Measurement? get slowestSession {
    return measurements.isNotEmpty
        ? measurements.reduce((a, b) =>
            (a.leftSteps + a.rightSteps) / a.sessionDuration <
                    (b.leftSteps + b.rightSteps) / b.sessionDuration
                ? a
                : b)
        : null;
  }

  // Periods of inactivity (assuming inactivity means steps < 2 in session)
  List<Measurement> get inactivePeriods {
    return measurements.where((m) => m.leftSteps + m.rightSteps < 2).toList();
  }

  // Calculate speed for each session (assuming each step covers 0.7m)
  List<double> get sessionSpeeds {
    return measurements
        .map((m) =>
            ((m.leftSteps + m.rightSteps) * 0.7) / m.sessionDuration) // meters per second
        .toList();
  }

  // Start and end times of the entire analysis
  String get startTime => measurements.isNotEmpty
      ? measurements.first.onlyTimeStartTime
      : "No Data";
  String get endTime => measurements.isNotEmpty
      ? measurements.last.onlyTimeEndTime
      : "No Data";

  // Additional insights
  List<String> get additionalInsights {
    List<String> insights = [];

    if (totalLeftSteps != totalRightSteps) {
      insights.add("There is an imbalance in left and right steps.");
    }

    if (sessionSpeeds.any((speed) => speed < 0.5)) {
      insights.add("Some sessions indicate slow walking, which may suggest fatigue.");
    }

    if (sessionSpeeds.any((speed) => speed > 2.0)) {
      insights.add("Fast-paced running detected, indicating high activity.");
    }

    return insights;
  }
}
