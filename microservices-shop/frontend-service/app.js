// const express = require("express");
// const axios = require("axios");
// const app = express();
// const PORT = process.env.PORT || 3000;

// const PRODUCT_API = process.env.PRODUCT_API || "http://product-service:8081/products";
// const OFFER_API = process.env.OFFER_API || "http://offer-service:8082/offers";

// console.log("Frontend service starting...");
// console.log("Environment variables:");
// console.log("PRODUCT_API:", PRODUCT_API);
// console.log("OFFER_API:", OFFER_API);

// app.get("/", async (req, res) => {
//   console.log("Received request to /");
//   try {
//     const [productsResponse, offersResponse] = await Promise.all([
//       axios.get(PRODUCT_API, { timeout: 5000 }),
//       axios.get(OFFER_API, { timeout: 5000 })
//     ]);

//     const products = productsResponse.data;
//     const offers = offersResponse.data;

//     let html = `<h1>Simple Shop</h1><h2>Products</h2><ul>`;
//     products.forEach((p) => (html += `<li>${p.name} — $${p.price}</li>`));
//     html += `</ul><h2>Offers</h2><ul>`;
//     offers.forEach((o) => (html += `<li>${o.code} — ${o.discount}% off</li>`));
//     html += `</ul>`;
//     res.send(html);

//   } catch (error) {
//     console.error("Error:", error.message);
//     res.status(500).send(`
//       <h1>Error</h1>
//       <p>${error.message}</p>
//       <p>Backend services might be starting up. Please try again.</p>
//     `);
//   }
// });

// app.get("/health", (req, res) => {
//   res.json({ status: "OK", service: "frontend" });
// });

// app.listen(PORT, () => {
//   console.log(`Frontend service running on port ${PORT}`);
// });

const express = require("express");
const axios = require("axios");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 3000;

const PRODUCT_API =
  process.env.PRODUCT_API || "http://product-service:8081/products";
const OFFER_API = process.env.OFFER_API || "http://offer-service:8082/offers";

console.log("Frontend service starting...");
console.log("Environment variables:");
console.log("PRODUCT_API:", PRODUCT_API);
console.log("OFFER_API:", OFFER_API);

// Serve static files (index.html, CSS, JS, etc.)
app.use(express.static(path.join(__dirname)));

// API endpoint to fetch products
app.get("/api/products", async (req, res) => {
  try {
    const response = await axios.get(PRODUCT_API, { timeout: 5000 });
    res.json(response.data);
  } catch (error) {
    console.error("Error fetching products:", error.message);
    res.status(500).json({ error: "Failed to fetch products" });
  }
});

// API endpoint to fetch offers
app.get("/api/offers", async (req, res) => {
  try {
    const response = await axios.get(OFFER_API, { timeout: 5000 });
    res.json(response.data);
  } catch (error) {
    console.error("Error fetching offers:", error.message);
    res.status(500).json({ error: "Failed to fetch offers" });
  }
});

// Health check
app.get("/health", (req, res) => {
  res.json({ status: "OK", service: "frontend" });
});

// Serve index.html at root
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "index.html"));
});

app.listen(PORT, () => {
  console.log(`Frontend service running on http://localhost:${PORT}`);
});
