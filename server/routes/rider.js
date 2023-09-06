const express = require('express');
const riderRouter = express.Router();
const rider = require('../middlewares/rider');
const Order = require('../models/order');
const Rider = require('../models/rider');
const User = require('../models/user');

riderRouter.get('/rider/get-assigned-orders', rider, async (req, res) => {
  try {
    const user = await User.findById(req.user);
    const riderData = await Rider.findOne({ userId: user._id });

    if (!riderData) {
      return res
        .status(404)
        .json({ error: 'Restaurant not found for this user' });
    }

    const orders = await Order.find({ riderId: riderData._id, status: 1 });
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

riderRouter.post('/rider/complete-order', rider, async (req, res) => {
  try {
    const { id } = req.body;
    const user = await User.findById(req.user);
    let rider = await Rider.findOne({ userId: user._id });

    let order = await Order.findById(id);
    order.status = 2;
    order = await order.save();
    rider.status = 'available';
    rider = await rider.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = riderRouter;
