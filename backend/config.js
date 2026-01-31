// Backend config — same server as Flutter web (port 5000).
// Change baseURL if you use a domain. MONGODB: set after MongoDB is installed.
module.exports = {
  PORT: process.env.PORT || 5000,
  baseURL: process.env.BASE_URL || "http://165.232.74.201:5000/",
  secretKey: process.env.SECRET_KEY || "5TIvw5cpc0",
  JWT_SECRET: process.env.JWT_SECRET || "2FhKmINItB",
  MONGODB_CONNECTION_STRING: process.env.MONGODB_CONNECTION_STRING || "mongodb://127.0.0.1:27017/erashop",
};
