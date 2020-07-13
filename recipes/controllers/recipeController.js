const Recipe = require('./../models/Recipe');
const catchAsync = require('./../utils/catchAsync');
const AppError = require('../utils/appError');

exports.createRecipe = catchAsync(async (req, res, next) => {
  const recipe = await Recipe.create(req.body);
  res.status(201).json({
    status: 'success',
    data: {
      recipe,
    },
  });
});

exports.getAllRecipes = catchAsync(async (req, res, next) => {
  const recipes = await Recipe.find().sort({
    date: -1,
  }); //date : 1 for oldest first
  res.status(200).json({
    status: 'success',
    results: recipes.length,
    data: {
      recipes,
    },
  });
});

exports.getRecipeByName = catchAsync(async (req, res, next) => {
  var search = req.params.id;
  const recipes = await Recipe.find({
    name: {
      $regex: search + '.*',
      $options: 'r',
    },
  });

  if (!recipes) {
    return res.status(404).json({ msg: 'Recipes not found' });
  }

  res.status(200).json({
    status: 'success',
    data: {
      recipes,
    },
  });
});

exports.updateRecipeById = catchAsync(async (req, res, next) => {
  const recipe = await Recipe.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
    runValidators: true,
  });

  if (!recipe) {
    return next(new AppError('No recipe found with that id', 404));
  }

  res.status(200).json({
    status: 'success',
    data: {
      recipe,
    },
  });
});

exports.getRecipeById = catchAsync(async (req, res, next) => {
  const recipe = await Recipe.findById(req.params.id);

  if (!recipe) {
    return next(new AppError('No recipe found with that id', 404));
  }

  res.status(200).json({
    status: 'success',
    data: {
      recipe,
    },
  });
});

exports.deleteRecipeById = catchAsync(async (req, res, next) => {
  const recipe = await Recipe.findByIdAndDelete(req.params.id);

  if (!recipe) {
    return next(new AppError('No recipe found with that id', 404));
  }

  await recipe.remove();
  res.status(204).json({
    status: 'success',
    data: null,
  });
});
