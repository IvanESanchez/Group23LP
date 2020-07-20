import 'package:my_recipe_box/Ingredient.dart';

class Recipe {
  String title;
  String instructions;
  List<Ingredient> ingredients;
  Recipe(String t, String inst, List<Ingredient> ingr) {
    title = t;
    instructions = inst;
    ingredients = ingr;
  }
}// TODO Implement this library.