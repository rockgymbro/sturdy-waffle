const express = require('express')
const app = express()
const cors = require('cors')
require('dotenv').config()
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

mongoose.connect(process.env.MONGO_URL);

const userSchema = new mongoose.Schema({
  username: String
});
const User = mongoose.model('User', userSchema);

const exerciseSchema = new mongoose.Schema({
  user_id: String,
  description: String,
  duration: Number,
  date: Date
})
const Exercise = mongoose.model('Exercise', exerciseSchema);

app.use(cors())
app.use(express.static('public'))
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/views/index.html')
});

app.use(bodyParser.urlencoded({ extended: false }));

app.post('/api/users', async (req, res) => {
  const user = new User({ username: req.body.username });
  await user.save();
  
  const savedUser = await User.findOne({ username: req.body.username }).exec();
  res.json({ username: savedUser.username, _id: savedUser._id });
});

app.get('/api/users', async (_req, res) => {
  const users = await User.find({});
  res.json(!users ? [] : users.map((u) => ({
    username: u.username,
    _id: u._id
  })));
})

app.post('/api/users/:_id/exercises', async (req, res, next) => {
  const user = await retrieveUser(req.params._id, next);

  const description = req.body.description;
  if (!description) {
    return next({ error: 'No description given' });
  }

  const duration = validateNumber(req.body.duration, next);

  const date = req.body.date ? validateDate(req.body.date, next) : new Date().setUTCHours(0,0,0,0);

  const exercise = new Exercise({
    user_id: user._id,
    description,
    duration,
    date
  });
  await exercise.save();

  res.json({
    username: user.username,
    description: exercise.description,
    duration: exercise.duration,
    date: exercise.date.toDateString(),
    _id: exercise.user_id
  });
});

app.get('/api/users/:_id/logs', async (req, res, next) => {
  const user = await retrieveUser(req.params._id, next);

  let filter = { user_id: user._id };
  Object.assign(filter, req.query.from || req.query.to ? { date: Object.assign({},
    req.query.from ? { $gte: validateDate(req.query.from, next) } : {},
    req.query.to ? { $lte: validateDate(req.query.to, next) } : {}
  )} : {});

  let dbQuery = Exercise.find(filter).sort({ 'date': -1 });
  dbQuery = req.query.limit ? dbQuery.limit(validateNumber(req.query.limit, next)) : dbQuery;
  let log = await dbQuery.exec();

  res.json({
    username: user.username,
    count: log.length,
    _id: user._id,
    log: log.map((e) => ({
      description: e.description,
      duration: e.duration,
      date: e.date.toDateString()
    }))
  });
});

app.use((err, _req, res, _next) => {
  res.json(err);
  console.log(err);
});

const retrieveUser = async (user_id, next) => {
  let user;
  try {
    user = await User.findById(user_id);
    if (!user) {
      return next({ error: `No user with id ${user_id} found` });
    }
  } catch (e) {
    if (e instanceof mongoose.CastError) {
      return next({ error: `${user_id} is not a valid user id` });
    } else {
      return next({ error: `Error occured when fetching user with id ${user_id}` });
    }
  }

  return user;
}

const validateDate = (dateString, next) => {
  const date = new Date(dateString)
  if (isNaN(date)) {
    return next({ error: `${dateString} is not a valid date` });
  }

  return date;
}

const validateNumber = (numString, next) => {
  const number = parseInt(numString);
  if (isNaN(number)) {
    return next({ error: `${numString} is not a valid number` });
  }

  return number;
}

const listener = app.listen(process.env.PORT || 3000, () => {
  console.log('Your app is listening on port ' + listener.address().port)
})
