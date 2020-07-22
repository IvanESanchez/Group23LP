import 'package:my_recipe_box/Ingredient.dart';
import 'package:my_recipe_box/Recipe.dart';
import 'package:my_recipe_box/globals.dart';



class Data {
  Data({
    this.recipes,
  });

  List<Recipe> recipes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    recipes: List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
  };
}