const express = require('express');

const recipeController = require('./../controllers/recipeController');
const authController = require('./../controllers/authController');

const ingredientRouter = require('./ingredientRoutes');
const router = express.Router();

router.use('/:recipeId/ingredients', ingredientRouter);

router
  .route('/')
  .get(recipeController.getAllRecipes)
  .post(
    authController.protect,
    recipeController.uploadRecipeImages,
    recipeController.resizeRecipeImages,
    recipeController.createRecipe
  );

router
  .route('/:id')
  .get(recipeController.getRecipeById)
  .patch(
    authController.protect,
    recipeController.uploadRecipeImages,
    recipeController.resizeRecipeImages,
    recipeController.updateRecipeById
  )
  .delete(authController.protect, recipeController.deleteRecipeById);

// This endpoint works fine now.
// We should really use queries to query for name but that can be added/fixed later if we have time.
router.route('/findRecipeByName/:name').get(recipeController.getRecipeByName);

module.exports = router;

// router.param('id', recipeController.checkId);
