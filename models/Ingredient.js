const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const IngredientSchema = new mongoose.Schema({
  userid: {
    // *TODO Ask the boys about doing this instead ****
    // type: Schema.ObjectId,
    // ref: 'User'
    type: String,
    required: [true, 'User is required'],
  },
  name: {
    type: String,
    required: [true, 'Name is required'],
  },
  unit: {
    type: String,
    required: [true, 'Unit is required'],
    unique: true,
  },
  amount: {
    type: Number,
    required: [true, 'Amount is required'],
  },
  categories: {
    type: [String],
  },
});

const Ingredient = mongoose.model('Ingredient', IngredientSchema);

module.exports = Ingredient;
