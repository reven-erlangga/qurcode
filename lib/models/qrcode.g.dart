// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qrcode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QrcodeAdapter extends TypeAdapter<Qrcode> {
  @override
  final int typeId = 0;

  @override
  Qrcode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Qrcode()
      ..barcode = fields[0] as String
      ..createdAt = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Qrcode obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.barcode)
      ..writeByte(1)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QrcodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
