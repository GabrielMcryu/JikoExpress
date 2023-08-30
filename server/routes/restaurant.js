const express = require('express');
const restaurantRouter = express.Router();
const restaurant = require('../middlewares/restaurant');
const { User } = require('../models/user');
const { Meal } = require('../models/meal');
const { PromiseProvider } = require('mongoose');
const { Restaurant } = require('../models/restaurant');

// Add Meal
restaurantRouter.post('/restaurant/add-meal', restaurant, async (req, res) => {
  try {
    const { name, description, images, price, category } = req.body;

    let user = await User.findById(req.user);

    const restaurantData = await Restaurant.findOne(user._id);

    if (!restaurantData) {
      return res.status(404).json({ message: 'Restaurant not found' });
    }

    let meal = new Meal({
      name,
      description,
      images,
      price,
      category,
      restaurantId: restaurantData._id,
    });
    meal = await meal.save();
    res.json(meal);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get meal by restaurant
restaurantRouter.get('/restaurant/get-meals', restaurant, async (req, res) => {
  let user = await User.findById(req.user);

  const restaurantData = await Restaurant.findOne(user._id);

  const meals = await Meal.find({ restaurantId: restaurantData._id });
  res.json(meals);
  try {
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = restaurantRouter;
