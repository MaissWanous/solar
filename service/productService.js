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
      if (!productData.category) {
        throw new Error("Missing required product fields (category, name, price).");
      }

      // 3. Attach shopId to productData
      productData.shopId = userShop.shopId;
      productData.price = parseInt(productData.price);

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

      if (!myProducts || myProducts.length === 0) {
        return { success: false, message: "No products found in your shop." };
      }

      // Transform data
      const cleanProducts = myProducts.map(product => {
        const base = {
          productId: product.productId,
          name: product.name ?? null,
          price: product.price ?? null,
          category: product.category,
          createdAt: product.createdAt,
          shop: {
            shopId: product.shop.shopId,
            shopname: product.shop.shopname ?? undefined,
            phone: product.shop.phone ?? undefined
          }
        };

        // Add category-specific info
        if (product.category === 'battery' && product.battery) {
          base.details = {
            batteryType: product.battery.batteryType,
            batterySize: product.battery.batterySize
          };
        } else if (product.category === 'inverter' && product.inverter) {
          base.details = {


            inverterRatingP: product.inverter.inverterRatingP,
            maxAc: product.inverter.maxAc,
            defaultAc: product.inverter.defaultAc,
            solarRatingP: product.inverter.solarRatingP,
            maxSolarVolt: product.inverter.maxSolarVolt,
            Mppt: product.inverter.Mppt
          };
        } else if (product.category === 'solar_panel' && product.solar_panel) {
          base.details = {
            maximumPower: product.solar_panel.maximumPower,
            shortCurrent: product.solar_panel.shortCurrent,
            openVoltage: product.solar_panel.openVoltage
          };
        }

        return base;
      });

      return {
        success: true,
        data: cleanProducts
      };

    } catch (err) {
      console.error("Error fetching products:", err);
      return {
        success: false,
        message: "Failed to retrieve products.",
        error: err.message
      };
    }
  }
  ,

  async getAllProducts() {
    try {
      const Products = await products.findAll({
        include: [
          {
            model: shop,
          },
          { model: battery, required: false },
          { model: inverter, required: false },
          { model: solar_panel, required: false }
        ]
      });
      console.log(products)

      if (!Products || Products.length === 0) {
        return { success: false, message: "No products found in your shop." };
      }

      // Transform data
      const cleanProducts = Products.map(product => {
        const base = {
          productId: product.productId,
          name: product.name ?? null,
          price: product.price ?? null,
          category: product.category,
          createdAt: product.createdAt,
          shop: {
            shopId: product.shop.shopId?? undefined,
            shopname: product.shop.shopname ?? undefined,
            phone: product.shop.phone ?? undefined
          }
        };

        // Add category-specific info
        if (product.category === 'battery' && product.battery) {
          base.details = {
            batteryType: product.battery.batteryType,
            batterySize: product.battery.batterySize
          };
        } else if (product.category === 'inverter' && product.inverter) {
          base.details = {


            inverterRatingP: product.inverter.inverterRatingP,
            maxAc: product.inverter.maxAc,
            defaultAc: product.inverter.defaultAc,
            solarRatingP: product.inverter.solarRatingP,
            maxSolarVolt: product.inverter.maxSolarVolt,
            Mppt: product.inverter.Mppt
          };
        } else if (product.category === 'solar_panel' && product.solar_panel) {
          base.details = {
            maximumPower: product.solar_panel.maximumPower,
            shortCurrent: product.solar_panel.shortCurrent,
            openVoltage: product.solar_panel.openVoltage
          };
        }

        return base;
      });

      return {
        success: true,
        data: cleanProducts
      };

    } catch (err) {
      console.error("Error fetching products:", err);
      return {
        success: false,
        message: "Failed to retrieve products.",
        error: err.message
      };
    }
  }
};

module.exports = productService;
