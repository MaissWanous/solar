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


router.get("/getMyProduct",  async (req, res) => { 
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
        const decoded = jwtService.verifyToken(token); // تحقق من صحة Refresh Token
    
        const user = await productService.getMyProduct(decoded.userId); // ابحث عن المستخدم بناءً على معرف المستخدم في التوكن
    
        if (!user) return res.status(403).json({ message: "Forbidden" });
    
        res.json({ user: user });
      } catch (error) {
        console.error(error);
        res.status(401).json({ message: "Unauthorized" });
      }
    //////////////
   
});

router.get("/getAllProduct",async(req,res)=>{
  try {
    const products = await productService.getAllProducts();
    res.status(200).json({ message: "get product successfully.", products });
} catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to get product." });
}
})

module.exports = router;