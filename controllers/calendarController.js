var Calendar = require('../models/Calendar');

//*TODO Check if everything still works after refactoring

const success = 200;
const badRequest = 400;
const serverError = 500;

// exports.createCalendar = async (req, res, next) => {
//   var userCalendar = {};
//   Calendar.create(
//     {
//       name: 'My Calendar',
//       mealType: [
//         { mealTypeId: 0, name: 'Breakfast' },
//         { mealTypeId: 1, name: 'Lunch' },
//         { mealTypeId: 2, name: 'Dinner' },
//         { mealTypeId: 3, name: 'Dessert' },
//         { mealTypeId: 4, name: 'Other' },
//       ],
//     },
//     function (calendar) {
//       user = req.body.user;

//       userCalendar = calendar;
//       if (user.calendar) {
//         console.log(userCalendar._id);
//         User.updateOne(
//           { _id: user.id },
//           {
//             $push: {
//               calendars: { calendarId: userCalendar._id },
//             },
//           },
//           function (err, userCalendar) {
//             if (err) {
//               console.log(err);
//             }
//             res.status(success).json({ recipe: { calendars: userCalendar._id } });
//           }
//         );
//       } else {
//         console.log(userCalendar._id);
//         User.updateOne(
          
//           { _id: user.id },
//           {
            
//             $addToSet: {
//               calendars: { calendarId: userCalendar._id },
//             },
//           },
//           function (err, userCalendar) {
//             if (err) {
//               console.log(err);
//             }
//             res.status(success).json({ recipe: { calendars: userCalendar._id } });
//           }
//         );
//       }
//     }
//   );
// };

exports.createCalendar = async (req,res,next) => {

  // if(req.user == null){
  //   res.status(badRequest).json({});
  //   return;
  // }

  var userId = req.user.id;
  var username = req.user.name;

  if(userId == null || username == null){
    res.status(badRequest).json({});
    return;
  }

  var calendar = new Calendar({
    name : username + " Calendar's",
    userid: userId,
  });
  await calendar.save();
  
  res.status(success).json({calendar});

}

exports.addRecipeToCalendar = async (req, res, next) => {
  
  var recipe = req.body.recipe;
  if(recipe  == null || req.user == null){
    res.status(badRequest).json({});
    return;
  }
    let name = recipe[0].name;
    let date = recipe[0].calendarDate;
    let userId = req.user.id;
    let calendarId = req.user.calendarId;

    let userCalendar = await Calendar.findOne({_id: calendarId});
    // If calendar doesn't exist
    if(!userCalendar){
      res.status(badRequest).json({});
      return;
    }

    if(userId == null || name == null || date == null){
      res.status(badRequest).json({});
      return;
    }

    // if (calendar.recipe) {
    //   Calendar.update(
    //     { _id: user.calendarId },
    //     {
    //       $push: {
    //         recipe: {
    //           name: name,
    //           day: date,
    //         },
    //       },
    //     },
    //     function (err, newEvent) {
    //       if (err) {
    //         console.log(err);
    //       }
    //       res.status(success).json({ recipe: { name: name, day: date } });
    //     }
    //   );
      Calendar.updateOne(
        { _id: calendarId},
        {
          $addToSet: {
            recipe: {
              name: name,
              calendarDate: date,
            },

          },
        },
        function (err, newEvent) {
          if (err) {
            console.log(err);
          }
          res.status(success).json({ recipe: {name: name, calendarDate: date}});
        }
      );
};

exports.deleteRecipeFromCalendar = async (req, res, next) => {
  
  if (req.body == null || req.user == null) {
    res.status(badRequest).json({});
    return;
  }

  var recipe = req.body.recipe;

  if(recipe){
    res.status(badRequest).json({});
    return;
  }

  let calId = req.user.calendarId;
  let recipeId = recipe[0]._id;
  
  if(calId == null || recipeId == null){
    res.status(badRequest).json({});
    return;
  }

  Calendar.findOne({ _id: calId}, function () {
      Calendar.updateOne(
        { _id: calId },
        {
          $pull: {
            recipe: {
              _id: recipeId,
            },
          },
        },
        function (err) {
          if (err) {
            console.log(err);
          }
          res.status(success).json({});
        }
      );
  });
};
