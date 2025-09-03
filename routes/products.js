const express = require("express");
const productService = require("../service/productService");
const jwtService = require("../service/jwtService");
const router = express.Router();

router.post("/addProduct", async (req, res) => {
  //  const { productData, additionalData } = req.body;
  const imageFile = req.files?.picture;
  const authHeader = req.headers.authorization;

  const productData = JSON.parse(req.body.productData);
  const additionalData = JSON.parse(req.body.additionalData);

  if (!authHeader) {
    return res.status(401).json({ message: "Missing Authorization header" });
  }

  const token = authHeader.split(" ")[1];
  if (!token) {
    return res.status(401).json({ message: "Invalid token format" });
  }

  try {
    const decoded = jwtService.verifyToken(token);
    const product = await productService.addProduct(decoded.userId, productData, additionalData, imageFile);
    res.status(200).json({ message: "Product added successfully", product });
  } catch (error) {
    console.error("Add product error:", error.message);
    res.status(500).json({ error: error.message || "Failed to add product." });
  }
});
router.put("/updateProduct/:productId", async (req, res) => {
  const { productData, additionalData } = req.body;
  const productId = parseInt(req.params.productId);
  const imageFile = req.files?.picture;
  const authHeader = req.headers.authorization;

  // const productData = JSON.parse(req.body.productData);
  //   const additionalData = JSON.parse(req.body.additionalData);

  if (!authHeader) {
    return res.status(401).json({ message: "Missing Authorization header" });
  }

  const token = authHeader.split(" ")[1];
  if (!token) {
    return res.status(401).json({ message: "Invalid token format" });
  }

  try {
    const decoded = jwtService.verifyToken(token);
    const product = await productService.updateProduct(productId, productData, additionalData, imageFile);
    res.status(200).json({ message: "Product update successfully", product });
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

router.post('/upload-product-pic', async (req, res) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader?.startsWith("Bearer ")) {
      return res.status(401).json({ error: "Missing or malformed token." });
    }

    const token = authHeader.split(" ")[1];
    const decoded = jwtService.verifyToken(token);
    const userId = decoded.userId;

    const imageFile = req.files?.productPic;
    console.log("req.files:", req.files);

    const dbPath = await productService.uploadProductPicture(userId, imageFile);

    res.status(200).json({ message: "Product picture uploaded successfully.", path: dbPath });
  } catch (err) {
    console.error("Upload error:", err);
    res.status(400).json({ error: err.message });
  }
});
router.post('/addReview', async (req, res) => {
  try {
    const authHeader = req.headers.authorization;
    const review =req.body;
    if (!authHeader?.startsWith("Bearer ")) {
      return res.status(401).json({ error: "Missing or malformed token." });
    }

    const token = authHeader.split(" ")[1];
    const decoded = jwtService.verifyToken(token);
    const userId = decoded.userId;

    const response = await productService.addReview(userId,review);

    res.status(200).json({ message: "Review added successfully." });
  } catch (err) {
    console.error("error:", err);
    res.status(400).json({ error: err.message });
  }
})

module.exports = router;
