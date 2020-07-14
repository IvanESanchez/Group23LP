const express = require('express');

const ingredientController = require('../controllers/ingredientController');
const authController = require('./../controllers/authController');

// mergeParams to get access the parameters of the routes and merge them
const router = express.Router({ mergeParams: true });

router
  .route('/')
  .get(authController.protect, ingredientController.getAllIngredients)
  .post(authController.protect, ingredientController.createIngredient)
  .delete(authController.protect, ingredientController.deleteIngredient);

module.exports = router;
