const {
  battery,
  inverter,
  solar_panel,
  products,
  shop,
  sequelize,
} = require("../models");

const productService = {
 async addProduct(userId, productData, additionalData) {
  const transaction = await sequelize.transaction();
  try {
    // 1. Find the shop associated with the user
    const userShop = await shop.findOne({
      where: { shopKeeperId: userId },
      transaction
    });

    if (!userShop) {
      throw new Error("No shop found for this user.");
    }

    // 2. Validate basic product data
    if (!productData.category ) {
      throw new Error("Missing required product fields (category, name, price).");
    }

    // 3. Attach shopId to productData
    productData.shopId = userShop.shopId;

    // 4. Create product
    const product = await products.create(productData, { transaction });

    if (!product || !product.productId) {
      throw new Error("Product creation failed.");
    }

    // 5. Add to the corresponding category table
    switch (productData.category.toLowerCase()) {
      case "battery":
        if (!additionalData.batteryType || !additionalData.batterySize) {
          throw new Error("Missing battery fields.");
        }
        await battery.create({
          productId: product.productId,
          ...additionalData
        }, { transaction });
        break;

      case "inverter":
        await inverter.create({
          productId: product.productId,
          ...additionalData
        }, { transaction });
        break;

      case "solar_panel":
        await solar_panel.create({
          productId: product.productId,
          ...additionalData
        }, { transaction });
        break;

      default:
        throw new Error(`Unsupported product category: ${productData.category}`);
    }

    // 6. Commit the transaction
    await transaction.commit();

    return product;

  } catch (err) {
    await transaction.rollback();
    console.error("Error adding product:", err.message);
    throw err;
  }
}
,

  async getMyProduct(userId) {
    try {
      const myProducts = await products.findAll({
        include: [
          {
            model: shop,
            where: { shopKeeperId: userId }
          },
          { model: battery, required: false },
          { model: inverter, required: false },
          { model: solar_panel, required: false }
        ]
      });

      if (myProducts.length === 0) {
        return { success: false, message: "No products found in your shop." };
      }

      return { success: true, data: myProducts };
    } catch (err) {
      console.error("Error fetching products:", err);
      return {
        success: false,
        message: "Failed to retrieve products.",
        error: process.env.NODE_ENV === "development" ? err.message : null
      };
    }
  },

  async getAllProducts() {
    try {
      const allProducts = await products.findAll({
        include: [
          { model: inverter, required: false },
          { model: solar_panel, required: false },
          { model: battery, required: false }
        ]
      });

      if (allProducts.length === 0) {
        return { success: false, message: "No products found in shops." };
      }

      return { success: true, data: allProducts };
    } catch (err) {
      console.error("Error fetching products:", err);
      return {
        success: false,
        message: "Failed to retrieve products.",
        error: process.env.NODE_ENV === "development" ? err.message : null
      };
    }
  }
};

module.exports = productService;
