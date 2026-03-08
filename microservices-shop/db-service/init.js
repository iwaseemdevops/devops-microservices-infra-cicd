// db-service/init.js
db = db.getSiblingDB("shop");

db.products.deleteMany({});
db.offers.deleteMany({});

db.products.insertMany([
  { name: "Laptop", price: 1000 },
  { name: "Phone", price: 500 },
]);

db.offers.insertMany([
  { code: "WELCOME10", discount: 10 },
  { code: "FEST20", discount: 20 },
]);
