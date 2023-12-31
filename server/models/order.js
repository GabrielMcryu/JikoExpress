const mongoose = require('mongoose');
const { mealSchema } = require('./meal');

const orderSchema = mongoose.Schema({
  meals: [
    {
      meal: mealSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
  totalPrice: {
    type: Number,
    required: true,
  },
  address: {
    type: String,
    required: true,
  },
  userId: {
    required: true,
    type: String,
  },
  restaurantId: {
    required: true,
    type: String,
  },
  riderId: {
    type: String,
    default: '',
  },
  orderedAt: {
    type: Number,
    required: true,
  },
  status: {
    type: Number,
    default: 0,
  },
});

const Order = mongoose.model('Order', orderSchema);
module.exports = Order;
