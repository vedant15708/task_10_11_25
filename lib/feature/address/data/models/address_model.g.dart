// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressModelAdapter extends TypeAdapter<AddressModel> {
  @override
  final int typeId = 0;

  @override
  AddressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressModel(
      fullAddress: fields[0] as String,
      city: fields[1] as String,
      state: fields[2] as String,
      zipCode: fields[3] as String,
      country: fields[4] as String,
      isDefault: fields[5] as bool,
      unitNumber: fields[6] as String?,
      deliveryInstruction: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.fullAddress)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.state)
      ..writeByte(3)
      ..write(obj.zipCode)
      ..writeByte(4)
      ..write(obj.country)
      ..writeByte(5)
      ..write(obj.isDefault)
      ..writeByte(6)
      ..write(obj.unitNumber)
      ..writeByte(7)
      ..write(obj.deliveryInstruction);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
