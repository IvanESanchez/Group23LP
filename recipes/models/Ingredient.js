const mongoose = require('mongoose');

const IngredientSchema = new mongoose.Schema({
  userid: {
    type: String,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  unit: {
    type: String,
    required: true,
    unique: true,
  },
  amount: {
    type: Number,
    required: true,
  },
  categories: {
    type: [String],
  },
});

const Ingredient = mongoose.model('Ingredient', IngredientSchema);

module.exports = Ingredient;
