const express = require("express");
const productService = require("../service/productService");
const jwtService = require("../service/jwtService");
const router = express.Router();

router.post("/addProduct", async (req, res) => {
  const { productData, additionalData } = req.body;
  const authHeader = req.headers.authorization;

  if (!authHeader) {
    return res.status(401).json({ message: "Missing Authorization header" });
  }

  const token = authHeader.split(" ")[1];
  if (!token) {
    return res.status(401).json({ message: "Invalid token format" });
  }

  try {
    const decoded = jwtService.verifyToken(token);
    const product = await productService.addProduct(decoded.userId, productData, additionalData);
    res.status(200).json({ message: "Product added successfully", product });
  } catch (error) {
    console.error("Add product error:", error.message);
    res.status(500).json({ error: error.message || "Failed to add product." });
  }
});

router.get("/getMyProduct", async (req, res) => {
  const authHeader = req.headers.authorization;

  if (!authHeader) {
    return res.status(401).json({ message: "Missing Authorization header" });
  }

  const token = authHeader.split(" ")[1];
  if (!token) {
    return res.status(401).json({ message: "Invalid token format" });
  }

  try {
    const decoded = jwtService.verifyToken(token);
    const result = await productService.getMyProduct(decoded.userId);

    if (!result.success) {
      return res.status(404).json({ message: result.message });
    }

    res.status(200).json({ products: result.data });
  } catch (error) {
    console.error("Get my product error:", error.message);
    res.status(500).json({ message: "Unauthorized" });
  }
});

router.get("/getAllProduct", async (req, res) => {
  try {
    const result = await productService.getAllProducts();

    if (!result.success) {
      return res.status(404).json({ message: result.message });
    }

    res.status(200).json({ products: result.data });
  } catch (error) {
    console.error("Get all products error:", error.message);
    res.status(500).json({ error: "Failed to get product." });
  }
});

module.exports = router;
