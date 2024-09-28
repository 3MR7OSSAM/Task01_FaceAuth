import 'package:hive/hive.dart';
import 'face_features.dart';

part 'user_model.g.dart'; // Required for Hive generation

@HiveType(typeId: 0) // Specify a unique typeId for this model
class UserModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? image;

  @HiveField(3)
  FaceFeatures? faceFeatures;

  @HiveField(4)
  DateTime? registeredOn;

  UserModel({
    this.id,
    this.name,
    this.image,
    this.faceFeatures,
    this.registeredOn,
  });

  // Hive doesn't support DateTime and complex objects, so serialize it yourself
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      faceFeatures: FaceFeatures.fromJson(json["faceFeatures"]),
      registeredOn: DateTime.parse(json['registeredOn']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'faceFeatures': faceFeatures?.toJson() ?? {},
      'registeredOn': registeredOn?.toIso8601String(),
    };
  }
}
