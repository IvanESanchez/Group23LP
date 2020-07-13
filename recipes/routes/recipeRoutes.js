const express = require('express');

const recipeController = require('./../controllers/recipeController');
const authController = require('./../controllers/authController');

const router = express.Router();

router
  .route('/')
  .get(authController.protect, recipeController.getAllRecipes)
  .post(authController.protect, recipeController.createRecipe);

router
  .route('/:id')
  .get(authController.protect, recipeController.getRecipeById)
  .patch(authController.protect, recipeController.updateRecipeById)
  .delete(authController.protect, recipeController.deleteRecipeById);

router.route('/:name').get(recipeController.getRecipeByName);

module.exports = router;

// router.param('id', recipeController.checkId);
