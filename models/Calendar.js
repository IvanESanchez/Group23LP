const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const CalendarSchema = new Schema({
  name: {
    type: String,
    required: [true, 'Name is required'],
  },
  userid: {
    // *TODO Ask the boys about doing this instead ****
    // type: Schema.ObjectId,
    // ref: 'User'
    type: String,
    required: [true, 'User is required'],
  },
  recipe: {
    type: Schema.ObjectId,
    ref: 'Recipe',
    day: String,
  },
  mealType: {
    type: String,
    mealTypeId: Number,
  },
});

const Calendar = mongoose.model('Calendar', CalendarSchema);

module.exports = Calendar;
