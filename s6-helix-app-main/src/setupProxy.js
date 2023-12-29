const { createProxyMiddleware } = require('http-proxy-middleware');
//Change api request adress 
module.exports = function(app) {
  app.use(
    '/app',
    createProxyMiddleware({
      target: "https://api.efteling.com",
      changeOrigin: true,
    })
  );
};