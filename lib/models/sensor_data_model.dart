import 'package:intl/intl.dart';

class SensorData {
  final double ax, ay, az, gx, gy, gz, accMagnitude, gyroMagnitude;
  final String id;
  final String side;
  final double timeDiff;
  final DateTime time;

  SensorData({
    required this.ax,
    required this.ay,
    required this.az,
    required this.gx,
    required this.gy,
    required this.gz,
    required this.id,
    required this.side,
    required this.timeDiff,
    required this.time,
    required this.accMagnitude,
    required this.gyroMagnitude,
  });

  // format the time
  String get formattedTime => DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(time);

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      ax: json['ax'],
      ay: json['ay'],
      az: json['az'],
      gx: json['gx'],
      gy: json['gy'],
      gz: json['gz'],
      id: json['id'],
      side: json['side'],
      timeDiff: json['time_diff'] ?? 0.0, 
      time: DateTime.parse(json['time']), 
      accMagnitude: json['acc_magnitude'],
      gyroMagnitude: json['gyro_magnitude'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'side': side,
      'ax': ax,
      'ay': ay,
      'az': az,
      'gx': gx,
      'gy': gy,
      'gz': gz,
      'time': formattedTime,
      'time_diff': timeDiff,
      'acc_magnitude': timeDiff,
      'gyro_magnitude': timeDiff,
    };
  }
}
