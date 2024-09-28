// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_features.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FaceFeaturesAdapter extends TypeAdapter<FaceFeatures> {
  @override
  final int typeId = 3;

  @override
  FaceFeatures read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FaceFeatures(
      rightMouth: fields[6] as Points?,
      leftMouth: fields[7] as Points?,
      leftCheek: fields[5] as Points?,
      rightCheek: fields[4] as Points?,
      leftEye: fields[3] as Points?,
      rightEar: fields[0] as Points?,
      leftEar: fields[1] as Points?,
      rightEye: fields[2] as Points?,
      noseBase: fields[8] as Points?,
      bottomMouth: fields[9] as Points?,
    );
  }

  @override
  void write(BinaryWriter writer, FaceFeatures obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.rightEar)
      ..writeByte(1)
      ..write(obj.leftEar)
      ..writeByte(2)
      ..write(obj.rightEye)
      ..writeByte(3)
      ..write(obj.leftEye)
      ..writeByte(4)
      ..write(obj.rightCheek)
      ..writeByte(5)
      ..write(obj.leftCheek)
      ..writeByte(6)
      ..write(obj.rightMouth)
      ..writeByte(7)
      ..write(obj.leftMouth)
      ..writeByte(8)
      ..write(obj.noseBase)
      ..writeByte(9)
      ..write(obj.bottomMouth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FaceFeaturesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
