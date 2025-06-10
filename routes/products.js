const express = require("express");
const productService = require("../service/productService");
const jwtService = require("../service/jwtService");
const router = express.Router();

// ✅ إضافة منتج
router.post("/addProduct", async (req, res) => {
    const { productData, additionalData } = req.body;
    const authHeader = req.headers.authorization;
    console.log(authHeader)
    if (!authHeader) {
        return res.status(401).json({
            message: "Unauthorized: Missing Authorization header",
        });
    }
    const token = authHeader.split(" ")[1];
    console.log(token)
    if (!token) {
        return res
            .status(401)
            .json({ message: "Unauthorized: Invalid token format" });
    }
    try {
        const decoded = jwtService.verifyToken(token);

        const product = await productService.addProduct(decoded.userId, productData, additionalData);
        res.status(200).json({ message: "Product added successfully.", product });
        const user = await userService.findById();
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Failed to add product." });
    }
});

// ✅ جلب المنتجات الخاصة بالمستخدم
// router.get("/getMyProduct", async (req, res) => {
//     try {
//         const user = req.user; // الحصول على بيانات المستخدم من التوكن
//         const products = await productService.getMyProduct(user); // ✅ استخدام await
//         res.status(200).json({ message: "Products retrieved successfully.", products });
//     } catch (error) {
//         console.error(error);
//         res.status(500).json({ error: "Failed to retrieve products." });
//     }
// });

module.exports = router;