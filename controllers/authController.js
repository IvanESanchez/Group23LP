const { promisify } = require('util');
const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const fs = require('fs');

const User = require('./../models/User');
const catchAsync = require('./../utils/catchAsync');
const AppError = require('../utils/appError');
const Email = require('../utils/email');

const signToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });
};

const createSendToken = (user, statusCode, req, res) => {
  const token = signToken(user._id);

  const cookieOptions = {
    expires: new Date(
      Date.now() + process.env.JWT_COOKIE_EXPIRES_IN * 24 * 60 * 60 * 1000
    ),
    httpOnly: true,
    //Check if the connection is secured. Test headers in heroku. Heroku acts as a proxy
    secure: req.secure || req.headers('x-forwarded-proto') === 'https',
  };

  res.cookie('jwt', token, cookieOptions);

  // Hide password and isVerified from output
  user.password = undefined;
  user.isVerified = undefined;

  res.status(statusCode).json({
    status: 'success',
    token,
    data: {
      user,
    },
  });
};

async function generateTokenAndSendEmail(user, funcionality, req, res, next) {
  // Generate token
  const token = user.createToken();
  await user.save({ validateBeforeSave: false });

  //Send it as an email
  try {
    const resetURL = `${req.protocol}://${req.get(
      'host'
    )}/api/users/${funcionality}/${token}`;

    if (funcionality === 'verifyEmail') {
      await new Email(user, resetURL).sendVerificationEmail();
    } else if (funcionality === 'resetPassword') {
      await new Email(user, resetURL).sendPasswordReset();
    }

    res.status(200).json({
      status: 'success',
      message: 'Token sent to email',
    });
  } catch (err) {
    user.token = undefined;
    user.tokenExpires = undefined;
    await user.save({ validateBeforeSave: false });

    return next(
      new AppError('There was an error sending the email. Try again later', 500)
    );
  }
}

exports.signup = catchAsync(async (req, res, next) => {
  const { name, email, password, passwordConfirm } = req.body;

  const newUser = await User.create({ name, email, password, passwordConfirm });

  await generateTokenAndSendEmail(newUser, 'verifyEmail', req, res, next);
});

exports.verifyEmail = catchAsync(async (req, res, next) => {
  const hashedToken = crypto
    .createHash('sha256')
    .update(req.params.token)
    .digest('hex');

  const user = await User.findOne({
    token: hashedToken,
  });

  if (!user) {
    return next(new AppError('Token is invalid', 400));
  }
  if (user.tokenExpires > Date.now()) {
    user.token = undefined;
    user.tokenExpires = undefined;

    user.isVerified = true;

    await user.save();

    // Log the user in, send JWT
    createSendToken(user, 200, req, res);
  } else {
    // Token is expired. Create a new one and send email again
    await generateTokenAndSendEmail(user, 'verifyEmail', req, res, next);
  }
});

exports.login = catchAsync(async (req, res, next) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return next(new AppError('Please provide email and password', 400));
  }

  const user = await User.findOne({ email }).select('+password');

  if (!user || !(await user.correctPassword(password, user.password))) {
    return next(new AppError('Incorrect email or password', 401));
  }

  if (!user.isVerified) {
    return next(new AppError('You need to verify your email', 401));
  }

  createSendToken(user, 200, req, res);
});

exports.logout = (req, res) => {
  res.cookie('jwt', 'loggedOut', {
    expires: new Date(Date.now() + 10 * 1000),
    httpOnly: true,
  });
  res.status(200).json({ status: 'success' });
};

exports.protect = catchAsync(async (req, res, next) => {
  // 1) Check if token exists
  let token;
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith('Bearer')
  ) {
    token = req.headers.authorization.split(' ')[1];
  } else if (req.cookies.jwt) {
    token = req.cookies.jwt;
  }

  if (!token) {
    return next(new AppError('You are not logged in. Please log in'), 401);
  }
  // Verify token
  const decoded = await promisify(jwt.verify)(token, process.env.JWT_SECRET);
  // 2) Check if user still exists
  const freshUser = await User.findById(decoded.id);

  if (!freshUser) {
    return next(
      new AppError('The user belongin to this token no longer exists', 401)
    );
  }
  // 3) Check if user changed password after JWT was issued
  if (freshUser.changedPasswordAfter(decoded.iat)) {
    return next(
      new AppError('User recently changed password. Please log in again', 401)
    );
  }

  // Grant access to protected route

  req.user = freshUser;

  next();
});

exports.forgotPassword = catchAsync(async (req, res, next) => {
  //Get user based on posted email
  const user = await User.findOne({ email: req.body.email });

  if (!user) {
    return next(
      new AppError('There is no user associated to that email address', 404)
    );
  }
  await generateTokenAndSendEmail(user, 'resetPassword', req, res, next);
});

exports.resetPassword = catchAsync(async (req, res, next) => {
  //1) Get user based on token

  const hashedToken = crypto
    .createHash('sha256')
    .update(req.params.token)
    .digest('hex');

  const user = await User.findOne({
    token: hashedToken,
    tokenExpires: { $gt: Date.now() },
  });

  //2) Set the new password if token is valid and it has not expired

  if (!user) {
    return next(new AppError('Token is invalid or has expired', 400));
  }

  user.password = req.body.password;
  user.passwordConfirm = req.body.passwordConfirm;

  user.token = undefined;
  user.tokenExpires = undefined;

  //3) Update changedPasswordAt for user
  await user.save();

  //4) Log the user in, send JWT

  createSendToken(user, 200, req, res);
});

exports.updatePassword = catchAsync(async (req, res, next) => {
  const user = await User.findById(req.user.id).select('+password');

  //Check if posted password is correct

  if (!(await user.correctPassword(req.body.passwordCurrent, user.password))) {
    return next(new AppError('Your current password is incorrect', 401));
  }

  user.password = req.body.password;
  user.passwordConfirm = req.body.passwordConfirm;

  await user.save();

  const token = signToken(user._id);
  res.status(200).json({
    status: 'success',
    token,
  });
});

// Only for rendered pages!!! No errors
exports.isLoggedIn = async (req, res, next) => {
  if (req.cookies.jwt) {
    try {
      // Verify token
      const decoded = await promisify(jwt.verify)(
        req.cookies.jwt,
        process.env.JWT_SECRET
      );

      // 2) Check if user still exists
      const freshUser = await User.findById(decoded.id);

      if (!freshUser) {
        return next();
      }
      // 3) Check if user changed password after JWT was issued
      if (freshUser.changedPasswordAfter(decoded.iat)) {
        return next();
      }

      // There is a logged in user
      res.locals.user = freshUser;
      return next();
    } catch (err) {
      return next();
    }
  }
  next();
};

//Returns the password reset page
exports.passwordResetPage = async (req, res, next) => {
	res.sendFile(__dirname + '/passwordReset/password.html');
}
