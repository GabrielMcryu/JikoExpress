const express = require('express');
const mongoose = require('mongoose');
const User = require('../models/user');
const Restaurant = require('../models/restaurant');
const bcryptjs = require('bcryptjs');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');

// Sign Ip Route
authRouter.post('/api/signup', async (req, res) => {
  try {
    const { name, email, password, phoneNumber } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: 'User with same email already exists!' });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
      phoneNumber,
      role: 'customer',
    });
    user = await user.save();

    const userId = user._id;
    console.log(userId);
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post('/api/restaurant-signup', async (req, res) => {
  const session = await mongoose.startSession();
  session.startTransaction();

  try {
    const { name, email, password, phoneNumber, restaurantName } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: 'User with same email already exists!' });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
      phoneNumber,
      role: 'restaurant',
    });
    user = await user.save();

    const userId = user._id;

    let restaurant = new Restaurant({
      userId,
      name: restaurantName,
    });

    restaurant = await restaurant.save();

    await session.commitTransaction();
    session.endSession();

    res.status(200).json({ message: 'Transaction successful' });
  } catch (e) {
    await session.abortTransaction();
    session.endSession();

    console.error(error);
    res.status(500).json({ error: 'Transaction failed' });
  }
});

// Sign In Route
authRouter.post('/api/signin', async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: 'User with this email does not exist!' });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: 'Incorrect password.' });
    }

    const token = jwt.sign({ id: user._id, role: user.role }, 'passwordKey');
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post('/tokenIsValid', async (req, res) => {
  try {
    const token = req.header('x-auth-token');
    if (!token) return res.json(false);
    const verified = jwt.verify(token, 'passwordKey');
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get user data
authRouter.get('/', auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
