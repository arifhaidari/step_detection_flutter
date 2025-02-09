class Measurement {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final int leftSteps;
  final int rightSteps;
  late final Duration duration;

  Measurement({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.leftSteps,
    required this.rightSteps,
  }) {
    duration = endTime.difference(startTime); // Calculate duration
  }

  // String get formattedStartTime => startTime.toIso8601String();
  // String get formattedEndTime => endTime.toIso8601String();
  String get formattedDuration => '${duration.inSeconds} seconds';

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      id: json['id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      leftSteps: json['left_steps'],
      rightSteps: json['right_steps'],
    );
  }

   // format date and time 
  String get formattedStartTime {
    return "${startTime.toLocal().day.toString().padLeft(2, '0')}/${startTime.toLocal().month.toString().padLeft(2, '0')}/${startTime.toLocal().year} ${startTime.toLocal().hour.toString().padLeft(2, '0')}:${startTime.toLocal().minute.toString().padLeft(2, '0')}:${startTime.toLocal().second.toString().padLeft(2, '0')}";
  }

  String get formattedEndTime {
    return "${endTime.toLocal().day.toString().padLeft(2, '0')}/${endTime.toLocal().month.toString().padLeft(2, '0')}/${endTime.toLocal().year} ${endTime.toLocal().hour.toString().padLeft(2, '0')}:${endTime.toLocal().minute.toString().padLeft(2, '0')}:${endTime.toLocal().second.toString().padLeft(2, '0')}";
  }
}
