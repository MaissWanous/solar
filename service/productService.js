const {
  battery,
  inverter,
  solar_panel,
  products,
  shop,
  sequelize,
} = require("../models");
const path = require('path');
const fs = require('fs');

const productService = {
async addProduct(userId, productData, additionalData, imageFile) {
  const transaction = await sequelize.transaction();
  let product;

  try {
    // 1. Find the shop
    const userShop = await shop.findOne({
      where: { shopKeeperId: userId },
      transaction
    });

    if (!userShop) {
      throw new Error("No shop found for this user.");
    }

    // 2. Validate
    if (!productData.category || !productData.name || !productData.price) {
      throw new Error("Missing required product fields (category, name, price).");
    }

    // 3. Attach shopId
    productData.shopId = userShop.shopId;
    productData.price = parseInt(productData.price);

    // 4. Create product
    product = await products.create(productData, { transaction });

    // 5. Add to category table
    switch (productData.category.toLowerCase()) {
      case "battery":
        if (!additionalData.batteryType || !additionalData.batterySize) {
          throw new Error("Missing battery fields.");
        }
        await battery.create({ productId: product.productId, ...additionalData }, { transaction });
        break;
      case "inverter":
        await inverter.create({ productId: product.productId, ...additionalData }, { transaction });
        break;
      case "solar_panel":
        await solar_panel.create({ productId: product.productId, ...additionalData }, { transaction });
        break;
      default:
        throw new Error(`Unsupported product category: ${productData.category}`);
    }

    // 6. Commit DB changes
    await transaction.commit();

  } catch (err) {
    await transaction.rollback();
    console.error("Error adding product:", err.message);
    throw err;
  }

  // 7. Upload image 
  try {
    if (imageFile) {
      const validTypes = ['image/jpeg', 'image/png'];
      if (!validTypes.includes(imageFile.mimetype)) {
        throw new Error('Only JPEG and PNG files are allowed.');
      }

      if (imageFile.size > 2 * 1024 * 1024) {
        throw new Error('File size exceeds 2MB.');
      }

      const fileName = `${Date.now()}_${imageFile.name}`;
      const uploadDir = path.join(__dirname, '../public/uploads');

      if (!fs.existsSync(uploadDir)) {
        fs.mkdirSync(uploadDir, { recursive: true });
      }

      const uploadPath = path.join(uploadDir, fileName);
      const dbPath = `/uploads/${fileName}`;

      await imageFile.mv(uploadPath);

      // Save image path
      product.picture = dbPath;
      await product.save();
    }
  } catch (imgErr) {
    console.error("Image upload failed:", imgErr.message);
    // Optional: log or mark product as missing image, but don't throw
  }

  return product;
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
          picture:product.picture??null,
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
            shopId: product.shop.shopId ?? undefined,
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
  },
  async editProduct(userId, editProductData) {
    const userShop = await shop.findOne({
      where: { shopKeeperId: userId },
    });

    try {
      const existingProduct = await products.findOne({
        where: { productId: editProductData.productId, shopId: userShop.shopId },
      });

      if (!existingProduct) {
        throw new Error(
          "Product not found or you don't have permission to edit it"
        );
      }

      // تحديث المنتج الرئيسي
      await products.update(
        {
          name: editProductData.name,
          price: editProductData.price,
          category: editProductData.category,
          picture: editProductData.picture,
          shopId: editProductData.shopId,
        },
        {
          where: { productId: editProductData.productId },
        }
      );

      // تحديث inverter إذا وجد
      if (editProductData.inverter) {
        await inverter.update(
          {
            inverterRatingP: editProductData.inverter.inverterRatingP,
            maxAc: editProductData.inverter.maxAc,
            defaultAc: editProductData.inverter.defaultAc,
            solarRatingP: editProductData.inverter.solarRatingP,
            maxSolarVolt: editProductData.inverter.maxSolarVolt,
            Mppt: editProductData.inverter.Mppt,
          },
          {
            where: { productId: editProductData.productId },
          }
        );
      }

      // تحديث solar_panel إذا وجد
      if (editProductData.solar_panel) {
        await solar_panel.update(
          {
            maximumPower: editProductData.solar_panel.maximumPower,
            shortCurrent: editProductData.solar_panel.shortCurrent,
            openVoltage: editProductData.solar_panel.openVoltage,
          },
          {
            where: { productId: editProductData.productId },
          }
        );
      }

      // تحديث battery إذا وجد
      if (editProductData.battery) {
        await battery.update(
          {
            batteryType: editProductData.battery.batteryType,
            batterySize: editProductData.battery.batterySize,
          },
          {
            where: { productId: editProductData.productId },
          }
        );
      }

      const updatedProduct = await products.findOne({
        where: { productId: editProductData.productId },
        include: [
          { model: inverter },
          { model: solar_panel },
          { model: battery },
          { model: shop },
        ],
      });

      return {
        success: true,
        message: "Product updated successfully",
        product: updatedProduct,
      };
    } catch (error) {
      console.error("Error editing product:", error);
      throw new Error("Failed to edit product: " + error.message);
    }
  },
};

module.exports = productService;
