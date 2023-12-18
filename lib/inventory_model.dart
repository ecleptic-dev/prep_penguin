import 'package:hive_flutter/adapters.dart';
part 'inventory_model.g.dart';

@HiveType(typeId: 0)
class Inventory {
  @HiveField(0)
  String name;
  @HiveField(1)
  String quantity;
  @HiveField(2)
  String description;
  @HiveField(3)
  String expiration;
  
  Inventory(this.name, this.quantity, this.description, this.expiration);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'description': description,
      'expiration': expiration
    };
  }

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': String name,
        'quantity': String quantity,
        'description': String description,
        'expiration': String expiration,
      } =>
        Inventory(
          name,
          quantity,
          description,
          expiration,
        ),
      _ => throw const FormatException('Failed to load Inventory.'),
    };
  }

  get inventorys => null;
}