var User = require('../models/User');
var Calendar = require('../models/Calendar');
var Recipe = require('../models/Recipe');

//*TODO Check if everything still works after refactoring

const success = 200;
const badRequest = 400;

exports.createCalendar = function makeNewCalendar(user, callback) {
  var userCalendar = {};
  Calendar.create(
    {
      name: 'My Calendar',
      mealType: [
        { mealTypeId: 0, name: 'Breakfast' },
        { mealTypeId: 1, name: 'Lunch' },
        { mealTypeId: 2, name: 'Dinner' },
        { mealTypeId: 3, name: 'Dessert' },
        { mealTypeId: 4, name: 'Other' },
      ],
    },
    function (err, calendar) {
      if (err) {
        console.log('Cal DB create error: ', err);
        return callback(err, null, null);
      }

      userCalendar = calendar;
      if (user.calendars) {
        User.update(
          { _id: user.id },
          {
            $push: {
              calendars: { calendarId: userCalendar._id },
            },
          },
          function (err, userCalendar) {
            if (err) {
              console.log(err);
            }
            return callback(null, user, userCalendar);
          }
        );
      } else {
        User.update(
          { _id: user.id },
          {
            $addToSet: {
              calendars: { calendarId: userCalendar._id },
            },
          },
          function (err, userCalendar) {
            if (err) {
              console.log(err);
            }
            return callback(null, user, userCalendar);
          }
        );
      }
    }
  );
};

exports.addRecipe = async(req,res,next) => {

  Calendar.findOne({_id: req.body.calendar._id},function(err,calendar){

    if(req.body == null){
      res.status(badRequest).json({});
      return;
    }

    let name = req.body.name;

    if(calendar.recipe){
      Calendar.update({_id: calendar._id},
        { $push: {
          recipe: {
            name: name,
          }
        }
        }, function(err,newEvent){
          if(err){
            console.log(err);
          }
          res.status(success).json({});
          res.json({recipe:{name: name}});
        }
      );
    } 
    else{
      Calendar.update({_id: calendar._id},
        { $addToSet: {
          recipe: {
            name: name,
          }
        }
        }, function(err,newEvent){
          if(err){
            console.log(err);
          }
          res.status(success).json({});
          res.json({recipe:newEvent});
        }
      );
      
    }
  })
};

exports.deleteRecipe = async(req,res,next) => {

  if(req.body == null){
    res.status(badRequest).json({});
    return;
  }
  
  let calId = req.body.calendarId;
  let recipeId = req.body.recipeId;

  Calendar.findOne({_id: req.body.calendar._id},function(err,calendar){
    if(calendar){

      Calendar.update({"_id":callId}, {
        "$pull": {
          recipe:{
            "_id": recipeId
          }
        }
      }, function(err,deletedRecipe){
        if(err){
          console.log(err);
        }
        res.status(success).json({});
        res.json({deletedEvent: deletedRecipe});
      });
    }
  })
};
