const express = require("express");
const productService = require("../service/productService");

const router = express.Router();

router.post("/addProduct", async (req, res) => {
    const { productData, additionalData } = req.body;
    try {
        const product = await productService.addProduct(productData, additionalData);
        res.status(200).json({ message: "Product added successfully.", product });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to add product." });
    }
});

module.exports = router;