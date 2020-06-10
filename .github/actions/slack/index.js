const querystring = require('querystring');
const http = require('http');
const { URL } = require('url');

const core = require('@actions/core');
const github = require('@actions/github');

try {
  const text = core.getInput('text');
  const payload = JSON.stringify(github.context.payload, undefined, 2)
  core.info(`The event payload: ${payload}`);

  const data = querystring.stringify({ text });

  const webhookUrl = process.env.SLACK_WEBHOOK_URL;

  if (webhookUrl === undefined) {
    throw new Error('Specify secrets.SLACK_WEBHOOK_URL');
  }

  core.setSecret(webhookUrl);

  const url = new URL(webhookUrl);

  const options = {
      host: url.host,
      path: url.path,
      headers: {
          'Content-Type': 'application/json',
          'Content-Length': Buffer.byteLength(data)
      }
  };

  const request = http.request(options, function(res) {
    core.info('response status:', res.statusCode);
    core.info('response headers:', res.headers);
    res.setEncoding('utf8');
    res.on('data', function (chunk) {
        core.info('Response: ' + chunk);
    });
  });

  request.write(data);
  request.end();
} catch (error) {
  core.setFailed(error.message);
}
