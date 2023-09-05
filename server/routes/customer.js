const express = require('express');
const customerRouter = express.Router();
const auth = require('../middlewares/auth');
const User = require('../models/user');
const { Meal } = require('../models/meal');
const Restaurant = require('../models/restaurant');
const Order = require('../models/order');

// get all restaurants
customerRouter.get('/customer/get-restaurants', auth, async (req, res) => {
  try {
    const restaurants = await Restaurant.find({});
    res.json(restaurants);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

customerRouter.get('/customer/meals/:restaurantId', auth, async (req, res) => {
  try {
    const { restaurantId } = req.params;

    const meals = await Meal.find({ restaurantId });
    res.json(meals);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

customerRouter.post('/customer/add-to-cart', auth, async (req, res) => {
  try {
    const { id } = req.body;
    const meal = await Meal.findById(id);
    let user = await User.findById(req.user);

    if (user.cart.length == 0) {
      user.cart.push({ meal, quantity: 1 });
    } else {
      let isMealFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].meal._id.equals(meal._id)) {
          isMealFound = true;
        }
      }

      if (isMealFound) {
        let mealll = user.cart.find((meall) => meall.meal._id.equals(meal._id));
        mealll.quantity += 1;
      } else {
        user.cart.push({ meal, quantity: 1 });
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

customerRouter.delete(
  '/customer/remove-from-cart/:id',
  auth,
  async (req, res) => {
    try {
      const { id } = req.params;
      const meal = await Meal.findById(id);
      let user = await User.findById(req.user);

      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].meal._id.equals(meal._id)) {
          if (user.cart[i].quantity == 1) {
            user.cart.splicae(i, 1);
          } else {
            user.cart[i].quantity -= 1;
          }
        }
      }
      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// order meal
customerRouter.post('/customer/order', auth, async (req, res) => {
  try {
    const { cart, totalPrice, address } = req.body;
    let meals = [];

    const firstMealItem = cart[0];
    const restaurantId = firstMealItem.meal.restaurantId;

    for (let i = 0; i < cart.length; i++) {
      let meal = await Meal.findById(cart[i].meal._id);
      meals.push({ meal, quantity: cart[i].quantity });
      await meal.save();
    }

    let user = await User.findById(req.user);
    user.cart = [];
    user = await user.save();

    let order = new Order({
      meals,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getTime(),
      restaurantId,
    });
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

customerRouter.get('/customer/orders/me', auth, async (req, res) => {
  try {
    const orders = await Order.find({ userId: req.user });
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = customerRouter;
