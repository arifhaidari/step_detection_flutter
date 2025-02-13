import 'package:intl/intl.dart';

class SensorData {
  final double ax, ay, az, gx, gy, gz;
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
  });

  // whenever in th UI i use the data then I use PlutoCell(value: sensor.formattedTime),
  // instead of sensor.time
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
      timeDiff: double.parse(json['time_diff'].toString()), 
      time: DateTime.parse(json['time']), 
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
    };
  }
}
