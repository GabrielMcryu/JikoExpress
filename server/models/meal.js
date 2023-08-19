const mongoose = require('mongoose');

const mealSchema = mongoose.Schema({
  restaurantId: {
    type: String,
    required: true,
  },
  name: {
    required: true,
    type: String,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  images: [
    {
      type: String,
      required: true,
    },
  ],
  price: {
    type: Number,
    required: true,
  },
  category: {
    type: String,
    required: true,
  },
});

const Meal = mongoose.model('Meal', mealSchema);
module.exports = Meal;
