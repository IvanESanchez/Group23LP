const mongoose = require('mongoose');
const validator = require('validator');
const bcrypt = require('bcryptjs');
const crypto = require('crypto');

const UserSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Name is required'],
    trim: true,
  },
  email: {
    type: String,
    required: [true, 'Email is required'],
    unique: true,
    lowercase: true,
    validate: [validator.isEmail, 'Please provide a valid email'],
  },
  photo: {
    type: String,
    default: 'default.jpg',
  },
  password: {
    type: String,
    required: [true, 'Password is required'],
    minlength: 8,
    select: false,
  },
  passwordConfirm: {
    type: String,
    required: [true, 'Please confirm your password'],
    validate: {
      // This only works on CREATE and SAVE!!
      validator: function (el) {
        return el === this.password;
      },
      message: 'Passwords do not match',
    },
    select: false,
  },
  passwordChangedAt: Date,
  token: String,
  tokenExpires: Date,
  active: {
    type: Boolean,
    default: true,
    select: false,
  },
  isVerified: {
    type: Boolean,
    default: false,
  },
  createdAt: {
    type: Date,
    default: Date.now(),
  },
  calendars: [
    {
      calendarId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Calendar',
      },
    },
  ],
});

// Document middleware
UserSchema.pre('save', async function (next) {
  if (!this.isModified('password')) return next();

  // Cost parameter. Default ~= 12. CPU intensity
  this.password = await bcrypt.hash(this.password, 12);

  this.passwordConfirm = undefined;
  next();
});

UserSchema.pre('save', function (next) {
  if (!this.isModified('password') || this.isNew) return next();

  // Subtracting 1 second just to ensure the password change happens before the token is created
  this.passwordChangedAt = Date.now() - 1000;
  next();
});

// Query middleware

UserSchema.pre(/^find/, function (next) {
  this.find({ active: { $ne: false } }).select('-__v');
  next();
});

// Instance methods

//Check passwords
UserSchema.methods.correctPassword = async function (
  candidatePassword,
  userPassword
) {
  return await bcrypt.compare(candidatePassword, userPassword);
};

//Check if password was changed after generating token
UserSchema.methods.changedPasswordAfter = function (JWTTimestamp) {
  if (this.passwordChangedAt) {
    // Divide by 1000 to convert to seconds and base 10 number
    const changedTimestamp = parseInt(
      this.passwordChangedAt.getTime() / 1000,
      10
    );
    return JWTTimestamp < changedTimestamp;
  }

  return false;
};

//Create token to reset password
UserSchema.methods.createToken = function () {
  const newToken = crypto.randomBytes(32).toString('hex');

  this.token = crypto.createHash('sha256').update(newToken).digest('hex');

  this.tokenExpires = Date.now() + 10 * 60 * 1000;

  return newToken;
};

const User = mongoose.model('User', UserSchema);

module.exports = User;
