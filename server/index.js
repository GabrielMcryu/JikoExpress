// IMPORTS FROM PACKAGES
const express = require('express');
const mongoose = require('mongoose');
require('dotenv').config();

// IMPORTS FROM OTHER FILES
const authRouter = require('./routes/auth');

// mongodb credentials
const username = process.env.APP_USERNAME;
const password = process.env.APP_PASSWORD;

// INIT
const PORT = process.env.PORT || 3000;
const app = express();
const DB = `mongodb+srv://${username}:${password}@cluster0.8sycumm.mongodb.net/?retryWrites=true&w=majority`;

// middleware
app.use(express.json());
app.use(authRouter);

// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log('Connection Successful');
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, '0.0.0.0', () => {
  console.log(`connected at port ${PORT}`);
});
