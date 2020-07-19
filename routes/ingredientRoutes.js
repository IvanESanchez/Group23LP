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

// TO DO **************
// Ask Alex about doing the routing it in a RESTful way like above???
// I tested it and it works fine. I was able to create Ingredient, get all ingredients, and delete ingredient without an issue.
//
// Having get/post/delete/patch etc.

// Following convention that URIs should not be used to indicate that a CRUD function is performed.
// URIs should be used to uniquely identify resources and not any action upon them.
// HTTP request methods should be used to indicate which CRUD function is performed.

// router
//   .route('/list')
//   .get(authController.protect, ingredientController.getAllIngredients);
// router
//   .route('/addIngredient')
//   .post(authController.protect, ingredientController.createIngredient);
// router
//   .route('/removeIngredient')
//   .post(authController.protect, ingredientController.deleteIngredient);

module.exports = router;
