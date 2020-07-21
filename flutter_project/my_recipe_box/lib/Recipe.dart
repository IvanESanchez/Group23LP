import 'package:my_recipe_box/Ingredient.dart';

//import 'package:json_annotation/json_annotation.dart';

//@JsonSerializable(nullable: false)
class Recipe {
  String title;
  String instructions;
  List<Ingredient> ingredients;

  Map<String, dynamic> toJson() {
    return {
      'name': title,
      'ingredients': ingredients,
      'directions': instructions,
    };
  }

  Recipe(String t, String inst, List<Ingredient> ingr) {
    title = t;
    instructions = inst;
    ingredients = ingr;
  }

  factory Recipe.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['ingredients'] as List;
    List<Ingredient> ingredientsList = list.map((i) => Ingredient.fromJson(i)).toList();
    return Recipe(parsedJson['name'], parsedJson['directions'], ingredientsList);
  }
}