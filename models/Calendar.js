const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const CalendarSchema = new Schema({
  name: String,
  userid: {
    // *TODO Ask the boys about doing this instead ****
    // type: Schema.ObjectId,
    // ref: 'User'
    type: String,
    required: [true, 'User is required'],
  },
  mealType: {
    type: String,
    mealTypeId: Number,
  },
});

const Calendar = mongoose.model('Calendar', CalendarSchema);

module.exports = Calendar;
