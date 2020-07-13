const mongoose = require('mongoose');

const Schema = mongoose.Schema;

//const Ingredient = require('./Ingredient');

const RecipeSchema = new Schema({
  user: {
    type: Schema.Types.ObjectId,
  },
  name: {
    type: String,
    required: [true, 'Name is required'],
    unique: true,
    trim: true,
    minlength: [1, 'Name must have more than 1 character'],
  },
  ingredients: {
    //type: [Schema.Types.Ingredient],
    type: [String],
    required: [true, 'Ingredients are required'],
  },
  directions: {
    type: [String],
    required: [true, 'Directions are required'],
  },
  courses: {
    type: [String],
    enum: {
      values: ['breakfast', 'lunch', 'dinner', 'brunch'],
      message: 'Course is either: breakfast, lunch, brunch, or dinner',
    },
  },
  categories: {
    type: [String],
  },
  nutrition: {
    type: [String],
  },
  photos: {
    type: [String],
  },
  servingSize: {
    type: String,
  },
  prepTime: {
    type: Number,
  },
  cookTime: {
    type: Number,
  },
  isFavorite: {
    type: Boolean,
    default: false,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const Recipe = mongoose.model('Recipe', RecipeSchema);

module.exports = Recipe;
