const serverless = require('serverless-http');
const app = require('./index'); // Import your Express app

const handler = serverless(app);

module.exports.handler = handler; // Export the handler function for Lambda
