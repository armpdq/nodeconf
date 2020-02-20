var express = require('express');
var request = require('request');
var helmet = require('helmet');
var fs = require('fs');
const zbEmailVerifier = require('zb-email-verifier');

const helo = 'organization.org';
const from = 'mail@oranization.org';

const app = express();
app.use(helmet());

  app.get('/checkemail/:value', (req,res) => {
    //console.log('Got request');
     let value = `${req.params.value}`
     if (req.query.token !='KEY' || req.query.token == undefined) {
      res.send('Not authorized access!');
      return;
    }
    zbEmailVerifier.verify({
  helo: helo,
  from: from,
  to: value,
  debug: false, // default false
  catchalltest : true, // default false
  timeout: 10000 // default 5000
}).then(result => {
  //console.log(result);
res.send(result);

  // INVALID - email regexp validation failed
  // EXIST - email is existence
  // NOT_EXIST - email is not existence
  // CATCH_ALL - catch all smtp server

  // MXRECORD_TIMEOUT - resolve mx record timeout
  // MXRECORD_FAIL - resolve mx record fail
  // CONN_FAIL - connect fail smtp
  // CONN_TIMEOUT - connect timeout smtp
  // VERIFY_TIMEOUT
  // VERIFY_FAIL
  // UNKNOWN
});

  });

app.listen('3478', function() {
    //console.log('Server started on port 3478, proxied by Nginx on 88');
  });
