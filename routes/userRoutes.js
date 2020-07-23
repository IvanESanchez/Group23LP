const express = require('express');
const router = express.Router();

const authController = require('./../controllers/authController');
const userController = require('./../controllers/userController');

router.post('/signup', authController.signup);
router.post('/login', authController.login);
router.get('/logout', authController.logout);
router.get('/verifyEmail/:token', authController.verifyEmail);
router.post('/forgotPassword', authController.forgotPassword);
router.get('/resetPassword/:token', authController.passwordResetPage);
router.patch('/resetPassword/:token', authController.resetPassword);

// Protected routes
router.patch(
  '/updateMyPassword',
  authController.protect,
  authController.updatePassword
);

router.get(
  '/me',
  authController.protect,
  userController.getMe,
  userController.getUser
);

router.patch(
  '/updateMe',
  authController.protect,
  userController.uploadUserPhoto,
  userController.resizeUserPhoto,
  userController.updateMe
);

router.delete('/deleteMe', authController.protect, userController.deleteMe);

module.exports = router;
