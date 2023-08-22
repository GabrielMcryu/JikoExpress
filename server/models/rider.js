const mongoose = require('mongoose');

const riderSchema = mongoose.Schema({
  userId: {
    type: String,
    required: true,
  },
  restaurantId: {
    type: String,
    default: '',
  },
  drivingLicenseNumber: {
    type: String,
    required: true,
  },
});

const Rider = mongoose.model('Rider', riderSchema);
module.exports = Rider;
