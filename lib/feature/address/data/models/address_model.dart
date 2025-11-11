import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 0)
class AddressModel extends HiveObject {

  @HiveField(0)
  late String fullAddress;

  @HiveField(1)
  late String city;

  @HiveField(2)
  late String state;

  @HiveField(3)
  late String zipCode;

  @HiveField(4)
  late String country;

  @HiveField(5)
  late bool isDefault;

  @HiveField(6)
  String? unitNumber;

  @HiveField(7)
  String? deliveryInstruction;


  AddressModel({
    required this.fullAddress,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.isDefault = false,
    this.unitNumber,
    this.deliveryInstruction,
  });

  String get addressLine1 {
    String unit = (unitNumber != null && unitNumber!.isNotEmpty) ? ', ${unitNumber}' : '';
    return '$fullAddress$unit, $city';
  }

  String get addressLine2 {
    return '$state, $country, $zipCode';
  }
}