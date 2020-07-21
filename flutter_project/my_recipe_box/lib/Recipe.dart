import 'package:my_recipe_box/Ingredient.dart';
import 'package:my_recipe_box/globals.dart';

//import 'package:json_annotation/json_annotation.dart';

//@JsonSerializable(nullable: false)
class Recipe {
  String title;
  String instructions;
  //String token;
  List<Ingredient> ingredients;

  Map<String, dynamic> toJson() {
    return {
      'name': title,
      'ingredients': ingredients,
      'directions': instructions,
      //'token': token
    };
  }

  Recipe(String t, String inst, List<Ingredient> ingr) {
    title = t;
    instructions = inst;
    //this.token = token;
    ingredients = ingr;
  }

  factory Recipe.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['ingredients'] as List;
    List<Ingredient> ingredientsList = list.map((i) => Ingredient.fromJson(i)).toList();
    return Recipe(parsedJson['name'], parsedJson['directions'], /*parsedJson['token'],*/ ingredientsList);
  }
}