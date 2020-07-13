const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const CalendarSchema = new Schema({
    name: String,
    userid: {
		type: String,
		required: true
    },
    mealType: {
        type: String,
        mealTypeId: Number        
    }
});

var Calendar = mongoose.model("calendar", CalendarSchema);
module.exports= Calendar;



