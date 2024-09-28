import 'package:hive/hive.dart';
import 'points.dart';

part 'face_features.g.dart'; // Required for Hive code generation

@HiveType(typeId: 3) // Assign a unique typeId for FaceFeatures
class FaceFeatures {
  @HiveField(0)
  Points? rightEar;

  @HiveField(1)
  Points? leftEar;

  @HiveField(2)
  Points? rightEye;

  @HiveField(3)
  Points? leftEye;

  @HiveField(4)
  Points? rightCheek;

  @HiveField(5)
  Points? leftCheek;

  @HiveField(6)
  Points? rightMouth;

  @HiveField(7)
  Points? leftMouth;

  @HiveField(8)
  Points? noseBase;

  @HiveField(9)
  Points? bottomMouth;

  FaceFeatures({
    this.rightMouth,
    this.leftMouth,
    this.leftCheek,
    this.rightCheek,
    this.leftEye,
    this.rightEar,
    this.leftEar,
    this.rightEye,
    this.noseBase,
    this.bottomMouth,
  });

  factory FaceFeatures.fromJson(Map<String, dynamic> json) => FaceFeatures(
    rightMouth: Points.fromJson(json["rightMouth"]),
    leftMouth: Points.fromJson(json["leftMouth"]),
    leftCheek: Points.fromJson(json["leftCheek"]),
    rightCheek: Points.fromJson(json["rightCheek"]),
    leftEye: Points.fromJson(json["leftEye"]),
    rightEar: Points.fromJson(json["rightEar"]),
    leftEar: Points.fromJson(json["leftEar"]),
    rightEye: Points.fromJson(json["rightEye"]),
    noseBase: Points.fromJson(json["noseBase"]),
    bottomMouth: Points.fromJson(json["bottomMouth"]),
  );

  Map<String, dynamic> toJson() => {
    "rightMouth": rightMouth?.toJson() ?? {},
    "leftMouth": leftMouth?.toJson() ?? {},
    "leftCheek": leftCheek?.toJson() ?? {},
    "rightCheek": rightCheek?.toJson() ?? {},
    "leftEye": leftEye?.toJson() ?? {},
    "rightEar": rightEar?.toJson() ?? {},
    "leftEar": leftEar?.toJson() ?? {},
    "rightEye": rightEye?.toJson() ?? {},
    "noseBase": noseBase?.toJson() ?? {},
    "bottomMouth": bottomMouth?.toJson() ?? {},
  };
}
