var express = require("express");
const router = express.Router();

var User = require("../models/User");
var Calendar = require('../../models/Calendar');
var Recipe = require("recipes");

function makeNewCalendar(user,callback){
    var userCalendar = {};
    Calendar.create({
        name: 'My Calendar',
        mealType: [{mealTypeId: 0, name: 'Breakfast'},{mealTypeId: 1, name: 'Lunch'},{mealTypeId: 2, name: 'Dinner'}, {mealTypeId: 3, name: 'Dessert'}, {mealTypeId: 4, name: 'Other'}],

    }, function(err, calendar){
        if(err){
            console.log('Cal DB create error: ', err);
            return callback( err, null, null);
        }

        userCalendar = calendar;
        if(user.calendars) {
               User.update({_id: user.id},{$push: {
                 calendars: {calendarId: userCalendar._id}
                }},function(err,userCalendar){
                    if(err){
                      console.log(err)
                    }
                    return callback(null, user, userCalendar);
    });

    } else {
      User.update({_id: user.id},{$addToSet: {
        calendars: {calendarId: userCalendar._id}
       }}, function(err,userCalendar){
         if(err){
           console.log(err)
         }
            return callback(null, user, userCalendar);
       });
  }
})
}

router.post('/add', async(req,res,next) => {
    
});

module.exports = {router, makeNewCalendar};