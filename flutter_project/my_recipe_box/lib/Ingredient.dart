//import 'package:json_annotation/json_annotation.dart';

//@JsonSerializable(nullable: false)
class Ingredient {
  String name;
  double amount;
  String unit;

  Ingredient({
    this.name,
    this.unit,
    this.amount,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "unit": unit,
    "amount": amount,
  };
  /*Ingredient(String n, double a, String u) {
    name = n;
    amount = a;
    unit = u;
  }*/

  /*factory Ingredient.fromJson(Map<String, dynamic> parsedJson) {
    return Ingredient (
      parsedJson['name'],
      parsedJson['amount'].toDouble(),
      parsedJson['unit']
    );
  }*/
  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    name: json["name"],
    unit: json["unit"],
    amount: json["amount"].toDouble(),
  );
}