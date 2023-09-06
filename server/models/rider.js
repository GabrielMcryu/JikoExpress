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
  status: {
    type: String,
    default: 'available',
  },
});

const Rider = mongoose.model('Rider', riderSchema);
module.exports = Rider;
