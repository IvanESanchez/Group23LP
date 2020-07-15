const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const CalendarSchema = new Schema({
  name: {
    type: String,
    required: true,
  },
  userid: {
    type: String,
    required: true,
  },
  recipe: [RecipeSchema],
  mealType: {
    type: String,
    mealTypeId: Number,
  },
});

const Calendar = mongoose.model('Calendar', CalendarSchema);

module.exports = Calendar;
