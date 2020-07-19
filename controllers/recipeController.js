const multer = require('multer');
const sharp = require('sharp');
const Recipe = require('./../models/Recipe');
const catchAsync = require('./../utils/catchAsync');
const AppError = require('../utils/appError');

const multerStorage = multer.memoryStorage();

const filterObj = (obj, ...allowedFields) => {
  const newObj = {};
  Object.keys(obj).forEach((el) => {
    if (allowedFields.includes(el)) newObj[el] = obj[el];
  });
  return newObj;
};

const multerFilter = (req, file, cb) => {
  if (file.mimetype.startsWith('image')) {
    cb(null, true);
  } else {
    cb(new AppError('Not an image! Please upload only images.', 400), false);
  }
};

const upload = multer({
  storage: multerStorage,
  fileFilter: multerFilter,
});

exports.uploadRecipeImages = upload.array('photos', 3); //produces req.files instead of req.file

exports.resizeRecipeImages = catchAsync(async (req, res, next) => {
  if (!req.params.id) req.params.id = req.user.id;

  if (!req.files) return next();

  req.body.photos = [];
  await Promise.all(
    req.files.photos.map(async (file, i) => {
      const filename = `recipe-${req.params.id}-${Date.now()}-${i + 1}.jpeg`;

      await sharp(file.buffer)
        .resize(1080, 1080)
        .toFormat('jpeg')
        .jpeg({ quality: 90 })
        .toFile(`public/img/recipes/${filename}`);

      req.body.photos.push(filename);
    })
  );
  next();
});

exports.createRecipe = catchAsync(async (req, res, next) => {
  if (!req.body.user) req.body.user = req.user.id;
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

exports.updateRecipeById = catchAsync(async (req, res, next) => {
  const filteredBody = filterObj(
    req.body,
    'name',
    'ingredients',
    'directions',
    'courses',
    'categories',
    'nutrition',
    'photos',
    'servingSize',
    'prepTime',
    'cookTime'
  );
  const recipe = await Recipe.findByIdAndUpdate(req.params.id, filteredBody, {
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

exports.getRecipeByName = catchAsync(async (req, res, next) => {
  var search = req.params.name.trim();
  const recipes = await Recipe.find({
    name: {
      $regex: search + '.*',
      $options: 'i',
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
