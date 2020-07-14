const express = require('express');
const morgan = require('morgan');

// Security and sanitization
const rateLimit = require('express-rate-limit');
const helmet = require('helmet');
const mongoSanitize = require('express-mongo-sanitize');
const xss = require('xss-clean');
const hpp = require('hpp');

const AppError = require('./utils/appError');
const globalErrorHandler = require('./controllers/errorController');

const recipeRouter = require('./routes/recipeRoutes');
const userRouter = require('./routes/userRoutes');
const ingredientRouter = require('./routes/ingredientRoutes');
const calendarRouter = require('./routes/calendarRoutes');

const app = express();

// Global Middlewares

// Set security HTTP headers
app.use(helmet()); // App.use requires a function not a function call

//Development logging
if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev'));
}

// Body parser, reading data from the body into req.body
// Limit the amount of data that comes in the body
app.use(express.json({ limit: '10kb' }));

// Data sanitization against NoSQL query injection
app.use(mongoSanitize());

// Data sanitization against XSS.
// Cleans input from malicious html code. could have some evil JavaScript code for instance
app.use(xss());

//Serving static files
app.use(express.static(`${__dirname}/public`));

//API limiting
const limiter = rateLimit({
  max: 150,
  windowInMs: 60 * 60 * 1000,
  message: 'Too many requests from this IP, please try again in an hour',
});

app.use('/api', limiter);

// Define Routes
app.use('/api/recipes', recipeRouter);
app.use('/api/users', userRouter);
app.use('/api/ingredients', ingredientRouter);
app.use('/api/calendar', calendarRouter);

// Non-existing routes
app.all('*', (req, res, next) => {
  return next(
    new AppError(`Can't find ${req.originalUrl} on this server`, 404)
  );
});

app.use(globalErrorHandler);

module.exports = app;
