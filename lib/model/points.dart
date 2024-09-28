import 'package:hive/hive.dart';

part 'points.g.dart'; // Required for Hive code generation

@HiveType(typeId: 2) // Assign a unique typeId for Points
class Points {
  @HiveField(0)
  int? x;

  @HiveField(1)
  int? y;

  Points({
    required this.x,
    required this.y,
  });

  factory Points.fromJson(Map<String, dynamic> json) => Points(
    x: (json['x'] ?? 0) as int,
    y: (json['y'] ?? 0) as int,
  );

  Map<String, dynamic> toJson() => {'x': x, 'y': y};
}
