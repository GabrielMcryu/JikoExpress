const mongoose = require('mongoose');
const { mealSchema } = require('./meal');

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: 'Please enter a valid email address',
    },
  },
  password: {
    required: true,
    type: String,
  },
  phoneNumber: {
    required: true,
    type: String,
  },
  address: {
    type: String,
    default: '',
  },
  role: {
    type: String,
    default: 'user',
  },
  // cart: [
  //   {
  //     meal: mealSchema,
  //     quantity: {
  //       type: Number,
  //       required: true,
  //     },
  //   },
  // ],
});

const User = mongoose.model('User', userSchema);
module.exports = User;
