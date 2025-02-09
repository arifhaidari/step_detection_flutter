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
      timeDiff: json['time_diff'],
      time: DateTime.parse(json['time']), // Convert time string to DateTime
    );
  }
  
}
