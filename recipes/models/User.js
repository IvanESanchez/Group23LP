const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
    date: {
        type: Date,
        default: Date.now
    },
    isVerified: {
        type: Boolean,
        default: false
    },
    calendars: [{
        calendarId: {
          type: Schema.Types.ObjectId,
          ref: 'Calendar'
        }
      }]
});

module.exports = mongoose.model('user', UserSchema);
