const express = require('express');
const morgan = require('morgan');

const AppError = require('./utils/appError');
const globalErrorHandler = require('./controllers/errorController');

const recipeRouter = require('./routes/recipeRoutes');
const userRouter = require('./routes/userRoutes');

const app = express();

// Middleware
app.use(express.json());
if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev'));
}

// Define Routes
app.use('/api/recipes', recipeRouter);
app.use('/api/users', userRouter);

//TODO: Need to fix to fit to the new structure
// app.use('/api/shopping', require('./routes/api/shopping'));
// app.use('/api/calendar', require('./routes/api/calendar'));

// Non-existing routes
app.all('*', (req, res, next) => {
  return next(
    new AppError(`Can't find ${req.originalUrl} on this server`, 404)
  );
});

app.use(globalErrorHandler);

module.exports = app;
