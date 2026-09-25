const test = require('node:test');
const assert = require('node:assert');
const request = require('supertest');
const app = require('./app');

test('GET / responds with 200 and Hello World!', async () => {
  const res = await request(app).get('/');
  assert.strictEqual(res.statusCode, 200);
  assert.strictEqual(res.text, 'Hello World!');
});
