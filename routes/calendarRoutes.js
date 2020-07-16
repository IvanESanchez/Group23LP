const express = require('express');

const authController = require('./../controllers/authController');
const calendarController = require('../controllers/calendarController');

const router = express.Router();

  router.route('/').post(authController.protect, calendarController.createCalendar);
  router.route('/addToCalendar').post(authController.protect, calendarController.addRecipe);
  router.route('/deleteFromCalendar').post(authController.protect, calendarController.deleteRecipe);

module.exports = router;
