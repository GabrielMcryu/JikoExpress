const express = require('express');
const restaurantRouter = express.Router();
const restaurant = require('../middlewares/restaurant');
const User = require('../models/user');
const { Meal } = require('../models/meal');
const Rider = require('../models/rider');
const Order = require('../models/order');
const { PromiseProvider } = require('mongoose');
const Restaurant = require('../models/restaurant');

// Add Meal
restaurantRouter.post('/restaurant/add-meal', restaurant, async (req, res) => {
  try {
    const { name, description, images, price, category } = req.body;

    let user = await User.findById(req.user);

    const restaurantData = await Restaurant.findOne({ userId: user._id });

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
  try {
    const user = await User.findById(req.user);

    const restaurantData = await Restaurant.findOne({ userId: user._id });

    if (!restaurantData) {
      return res
        .status(404)
        .json({ error: 'Restaurant not found for this user' });
    }

    const meals = await Meal.find({ restaurantId: restaurantData._id });
    res.json(meals);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Delete the meal
restaurantRouter.post(
  '/restaurant/delete-meal',
  restaurant,
  async (req, res) => {
    try {
      const { id } = req.body;
      let meal = await Meal.findByIdAndDelete(id);
      res.json(meal);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

restaurantRouter.get(
  '/restaurant/get-free-riders',
  restaurant,
  async (req, res) => {
    try {
      const riders = await Rider.find({ restaurantId: '' });
      res.json(riders);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

restaurantRouter.post(
  '/restaurant/hire-rider',
  restaurant,
  async (req, res) => {
    try {
      const { id } = req.body;

      let rider = await Rider.findById(id);

      const user = await User.findById(req.user);

      const restaurantData = await Restaurant.findOne({ userId: user._id });

      if (!restaurantData) {
        return res
          .status(404)
          .json({ error: 'Restaurant not found for this user' });
      }

      rider.restaurantId = restaurantData._id;
      rider = await rider.save();
      res.json(rider);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

restaurantRouter.get(
  '/restaurant/get-restaurant-riders',
  restaurant,
  async (req, res) => {
    try {
      const user = await User.findById(req.user);

      const restaurantData = await Restaurant.findOne({ userId: user._id });

      if (!restaurantData) {
        return res
          .status(404)
          .json({ error: 'Restaurant not found for this user' });
      }

      const riders = await Rider.find({ restaurantId: restaurantData._id });
      res.json(riders);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

restaurantRouter.get(
  '/restaurant/get-available-restaurant-riders',
  restaurant,
  async (req, res) => {
    try {
      const user = await User.findById(req.user);

      const restaurantData = await Restaurant.findOne({ userId: user._id });

      if (!restaurantData) {
        return res
          .status(404)
          .json({ error: 'Restaurant not found for this user' });
      }

      const riders = await Rider.find({
        restaurantId: restaurantData._id,
        status: 'available',
      });
      res.json(riders);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

restaurantRouter.get(
  '/restaurant/get-restaurant-orders',
  restaurant,
  async (req, res) => {
    try {
      const user = await User.findById(req.user);

      const restaurantData = await Restaurant.findOne({ userId: user._id });

      if (!restaurantData) {
        return res
          .status(404)
          .json({ error: 'Restaurant not found for this user' });
      }

      const order = await Order.find({ restaurantId: restaurantData._id });
      res.json(order);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

restaurantRouter.post(
  '/restaurant/assign-order-to-rider',
  restaurant,
  async (req, res) => {
    try {
      const { orderId, riderId } = req.body;
      let order = await Order.findById(orderId);
      order.status = 1;
      order.riderId = riderId;
      order = await order.save();
      let rider = await Rider.findById(riderId);
      rider.status = 'busy';
      rider = await rider.save();
      res.json(order);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

module.exports = restaurantRouter;
