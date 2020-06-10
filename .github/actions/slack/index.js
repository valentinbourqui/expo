const core = require('@actions/core');
const github = require('@actions/github');
const { IncomingWebhook } = require('@slack/webhook');

(async () => {
  try {
    const text = core.getInput('text');
    const payload = JSON.stringify(github.context.payload, undefined, 2)
    core.info(`The event payload: ${payload}`);

    const webhookUrl = process.env.SLACK_WEBHOOK_URL;

    if (webhookUrl === undefined) {
      throw new Error('Specify secrets.SLACK_WEBHOOK_URL');
    }

    core.setSecret(webhookUrl);

    const webhook = new IncomingWebhook(webhookUrl);
    await webhook.send(text);
  } catch(error) {
    core.setFailed(error.message);
  }
})();
