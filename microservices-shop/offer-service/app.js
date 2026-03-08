const express = require("express");
const { MongoClient } = require("mongodb");

const PORT = process.env.PORT || 8082;
const MONGO_URI = process.env.MONGO_URI || "mongodb://mongo:27017/shop";

const app = express();
app.use(express.json());

const connectWithRetry = async (retries = 5, delay = 5000) => {
  for (let i = 0; i < retries; i++) {
    try {
      const client = await MongoClient.connect(MONGO_URI);
      const db = client.db();
      const coll = db.collection("offers");
      console.log("Connected to MongoDB", MONGO_URI);
      return coll;
    } catch (err) {
      console.error(`Mongo connection attempt ${i + 1} failed:`, err.message);
      if (i < retries - 1) {
        console.log(`Retrying in ${delay / 1000} seconds...`);
        await new Promise((resolve) => setTimeout(resolve, delay));
      }
    }
  }
  console.error("All MongoDB connection attempts failed");
  process.exit(1);
};

let coll;

connectWithRetry().then((collection) => {
  coll = collection;
});

app.get("/offers", async (req, res) => {
  if (!coll) {
    return res.status(503).json({ error: "Service not ready" });
  }
  try {
    const offers = await coll.find().toArray();
    res.json(offers);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.get("/health", (req, res) => {
  if (coll) {
    res.status(200).json({ status: "OK" });
  } else {
    res.status(503).json({ status: "Not ready" });
  }
});

app.listen(PORT, () => console.log(`offer-service listening on ${PORT}`));
