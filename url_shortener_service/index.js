require('dotenv').config();
const express = require('express');
const cors = require('cors');
const app = express();
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const dns = require('dns');
const { resolveObjectURL } = require('buffer');

// Basic Configuration
const port = process.env.PORT || 3000;

mongoose.connect(process.env.MONGO_URL, { useNewUrlParser: true, useUnifiedTopology: true })

const urlMappingSchema = new mongoose.Schema({
  short_url: {
    type: Number,
    required: true,
    unique: true
  },
  orig_url: {
    type: String,
    required: true,
    unique: true
  }
});
const URLMapping = mongoose.model('URLMapping', urlMappingSchema);

const counterSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    unique: true
  },
  count: {
    type: Number,
    required: true
  }
});
const Counter = mongoose.model('Counter', counterSchema);
const MAPPING_COUNTER_NAME = 'mapping_counter';

app.use(cors());

app.use('/public', express.static(`${process.cwd()}/public`));

app.get('/', function(req, res) {
  res.sendFile(process.cwd() + '/views/index.html');
});

// Your first API endpoint
app.get('/api/hello', function(req, res) {
  res.json({ greeting: 'hello API' });
});

app.use('/api/shorturl', bodyParser.urlencoded({ extended: false }));

app.post('/api/shorturl', async (req, res) => {
  const matches = /(https?:\/\/)(.*$)/g.exec(req.body.url);
  if (!matches) {
    res.json({ error: 'invalid url' });
    return;
  }

  [url, _protocol, domain] = matches;
  dns.lookup(domain, async (err, _addresses, _family) => {
    if (err) {
      res.json({ error: 'invalid url' });
      return;
    }
    
    let mappingCounter = await Counter.findOne({ name: MAPPING_COUNTER_NAME }).exec();
    if (!mappingCounter) {
      mappingCounter = new Counter({ name: MAPPING_COUNTER_NAME, count: 0 });
      await mappingCounter.save();
    }
    
    const urlMapping = await URLMapping.findOne({ orig_url: url }).exec();
    if (urlMapping) {
      res.json({ original_url: url, short_url: urlMapping.short_url });
      return;
    }
    
    let newMapping = new URLMapping({ orig_url: url, short_url: mappingCounter.count + 1 });
    await newMapping.save();
    mappingCounter.count++;
    await mappingCounter.save();
    
    res.json({ original_url: url, short_url: newMapping.short_url });
  });
});

app.get('/api/shorturl/:short_url', async (req, res) => {
  short_url = req.params.short_url;

  mapping = await URLMapping.findOne({ short_url });
  if (!mapping) {
    res.json({ error: 'invalid short url' });
  }

  res.redirect(mapping.orig_url);
});
  
app.listen(port, function() {
  console.log(`Listening on port ${port}`);
});