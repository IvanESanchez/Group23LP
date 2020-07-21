//import 'package:json_annotation/json_annotation.dart';

//@JsonSerializable(nullable: false)
class Ingredient {
  String name;
  double amount;
  String unit;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'unit': unit,
      'amount': amount,
    };
  }

  Ingredient(String n, double a, String u) {
    name = n;
    amount = a;
    unit = u;
  }

  factory Ingredient.fromJson(Map<String, dynamic> parsedJson) {
    return Ingredient (
      parsedJson['name'],
      parsedJson['amount'],
      parsedJson['unit']
    );
  }
}