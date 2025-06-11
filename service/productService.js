const {
  battery,
  inverter,
  solar_panel,
  products,
  shop,
  
  sequelize,
} = require("../models");

const productService = {
  async addProduct(productData, additionalData) {
    try {
      const transaction = await sequelize.transaction();
      const product = await products.create(productData, { transaction });

      if (productData.category === "battery") {
        await battery.create(
          { productId: product.productId, ...additionalData },
          { transaction }
        );
      } else if (productData.category === "inverter") {
        await inverter.create(
          { productId: product.productId, ...additionalData },
          { transaction }
        );
      } else if (productData.category === "solar_panel") {
        await solar_panel.create(
          { productId: product.productId, ...additionalData },
          { transaction }
        );
      }

      await transaction.commit();
      return product;
    } catch (err) {
      await transaction.rollback();
      throw err;
    }
  },

  async getMyProduct(user_id) {
    try {
      

      const myProducts = await products.findAll({
        include: [
          {
            model: shop,
            where: { shopKeeperId: user_id },
          },
          {
            model: battery,

          },
          {
            model: inverter,
          },
        ],
       
      });

      if (myProducts.length === 0) {
        return { 
          success: false,
          message: "No products found in your shop." 
        };
      }

      return {
        success: true,
        data: myProducts
      };
      
    } catch (err) {
      console.error("Error fetching products:", err);
      
      // Return user-friendly error message
      return {
        success: false,
        message: "Failed to retrieve products. Please try again later.",
        error: process.env.NODE_ENV === 'development' ? err.message : null
      };
    }
  },


async  getAllProducts() {
    try {
        const allProducts = await products.findAll({
            include: [
                { model: inverter, required: false },
                { model: solar_panel, required: false },
                { model: battery, required: false }
            ]
        });

        if (allProducts.length === 0) {
            return {
                success: false,
                message: "No products found in shops."
            };
        }

        return {
            success: true,
            data: allProducts
        };
    } catch (err) {
        console.error("Error fetching products:", err);

        return {
            success: false,
            message: "Failed to retrieve products. Please try again later.",
            error: process.env.NODE_ENV === 'development' ? err.message : null
        };
    }
}
  
};

module.exports = productService;
