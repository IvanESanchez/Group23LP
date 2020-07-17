const express = require('express');

const ingredientController = require('../controllers/ingredientController');
const authController = require('./../controllers/authController');

// mergeParams to get access the parameters of the routes and merge them
const router = express.Router({ mergeParams: true });

router.route('/list').get(authController.protect, ingredientController.getAllIngredients);
router.route('/addIngredient').post(authController.protect, ingredientController.createIngredient);
router.route('/removeIngredient').post(authController.protect, ingredientController.deleteIngredient);

module.exports = router;
