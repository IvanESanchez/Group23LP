const express = require('express');

const authController = require('./../controllers/authController');
const calendarController = require('../controllers/calendarController');

const router = express.Router();

router
  .route('/')
  .post(authController.protect, calendarController.createCalendar);

module.exports = router;
