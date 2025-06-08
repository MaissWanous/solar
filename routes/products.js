const express = require("express");
const productService = require("../service/productService");
const authenticateUser = require("../service/authService"); // ✅ استيراد المصادقة من authService
const router = express.Router();

// ✅ إضافة منتج
router.post("/addProduct", authenticateUser, async (req, res) => { 
    const { productData, additionalData } = req.body;
    const userId = req.user.userId; // الحصول على معرف المستخدم من التوكن

    try {
        const product = await productService.addProduct(userId, productData, additionalData);
        res.status(200).json({ message: "Product added successfully.", product });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to add product." });
    }
});

// ✅ جلب المنتجات الخاصة بالمستخدم
router.get("/getMyProduct", authenticateUser, async (req, res) => { 
    try {
        const user = req.user; // الحصول على بيانات المستخدم من التوكن
        const products = await productService.getMyProduct(user); // ✅ استخدام await
        res.status(200).json({ message: "Products retrieved successfully.", products });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to retrieve products." });
    }
});

module.exports = router;