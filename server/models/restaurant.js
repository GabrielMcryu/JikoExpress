const mongoose = require('mongoose');
const ratingSchema = required('./rating');

const restaurantSchema = mongoose.Schema({
  userId: {
    type: String,
    required: true,
  },
  name: {
    required: true,
    type: String,
    trim: true,
  },
  ratings: [ratingSchema],
});

const Restaurant = mongoose.model('Restaurant', restaurantSchema);
module.exports = Restaurant;
