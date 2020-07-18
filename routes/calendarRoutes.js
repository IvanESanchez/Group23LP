const express = require('express');

const authController = require('./../controllers/authController');
const calendarController = require('../controllers/calendarController');

const router = express.Router();

router
  .route('/')
  .post(authController.protect, calendarController.createCalendar);
router
  .route('/addToCalendar')
  .post(authController.protect, calendarController.addRecipeToCalendar);
router
  .route('/deleteFromCalendar')
  .delete(authController.protect, calendarController.deleteRecipeFromCalendar);

module.exports = router;
