class Ingredient {
  String name;
  double amount;
  String unit;

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