
const axios = require("axios");
const {
  battery,
  inverter,
  solar_panel,
  products,
  shop,
  sequelize,
  account,
  rating
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
      if (productData.category != 'other')
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
  async deleteProduct(userId, productId) {
    const transaction = await sequelize.transaction();
    try {

      const userShop = await shop.findOne({
        where: { shopKeeperId: userId },
        transaction
      });

      if (!userShop) {
        throw new Error("No shop found for this user.");
      }


      const product = await products.findOne({
        where: { productId, shopId: userShop.shopId },
        transaction
      });

      if (!product) {
        throw new Error("Product not found or you don't have permission to delete it.");
      }


      switch (product.category?.toLowerCase()) {
        case "battery":
          await battery.destroy({ where: { productId }, transaction });
          break;
        case "inverter":
          await inverter.destroy({ where: { productId }, transaction });
          break;
        case "solar_panel":
          await solar_panel.destroy({ where: { productId }, transaction });
          break;
      }


      await rating.destroy({ where: { productId }, transaction });


      if (product.picture) {
        const imagePath = path.join(__dirname, "../public", product.picture);
        if (fs.existsSync(imagePath)) {
          fs.unlinkSync(imagePath);
        }
      }


      await products.destroy({ where: { productId }, transaction });


      await transaction.commit();

      return { success: true, message: "Product deleted successfully." };
    } catch (err) {
      await transaction.rollback();
      console.error("Delete product error:", err.message);
      throw err;
    }
  }

  ,
  async updateProduct(productId, productData, additionalData, imageFile) {
    const transaction = await sequelize.transaction();
    let product;

    try {
      if (!productId) {
        throw new Error("Missing productId for update.");
      }

      if (!productData.price) {
        productData.price = 0;
      }

      if (!productData.category) {
        throw new Error("Missing required product fields (category).");
      }

      // 1. Attach shopId
      productData.price = parseInt(productData.price);

      // 2. Find the existing product
      product = await products.findByPk(productId, { transaction });
      if (!product) {
        throw new Error("Product not found.");
      }

      // 3. Update product fields
      await product.update(productData, { transaction });

      const category = productData.category.toLowerCase();


      // 4. update  category-specific entry
      switch (category) {
        case "battery":
          await battery.update(additionalData, {
            where: { productId: product.productId },
            transaction,
          });
          break;

        case "inverter":
          await inverter.update(additionalData, {
            where: { productId: product.productId },
            transaction,
          });
          break;

        case "solar_panel":
          await solar_panel.update(additionalData, {
            where: { productId: product.productId },
            transaction,
          });
          break;

        default:
          throw new Error(`Unsupported product category: ${productData.category}`);
      }

      await transaction.commit();

    } catch (err) {
      await transaction.rollback();
      console.error("Error updating product:", err.message);
      throw err;
    }

    // 6. Handle image upload (optional)
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

        // Save new image path
        product.picture = dbPath;
        await product.save();
      }
      else {
        product.picture = null;
        await product.save
      }
    } catch (imgErr) {
      console.error("Image upload failed:", imgErr.message);
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
          { model: solar_panel, required: false },
          { model: rating, as: 'ratings', required: false }
        ]
      });

      if (!myProducts || myProducts.length === 0) {
        return { success: false, message: "No products found in your shop." };
      }

      const cleanProducts = [];

      for (const product of myProducts) {
        const base = {
          productId: product.productId,
          name: product.name ?? null,
          price: product.price ?? null,
          picture: product.picture ?? null,
          category: product.category,
          createdAt: product.createdAt,
          shop: {
            shopId: product.shop.shopId,
            shopname: product.shop.shopname ?? undefined,
            phone: product.shop.phone ?? undefined
          },
          details: {},
          reviews: product.ratings?.map(r => r.review) || []
        };

        // إضافة تفاصيل حسب الفئة
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

        // تحليل الريفيوهات
        let positiveCount = 0;
        if (base.reviews.length > 0) {
          try {
            const response = await axios.post("http://localhost:5000/predict", {
              reviews: base.reviews
            });
            const predictions = response.data.predictions;
            positiveCount = predictions.filter(p => p === 'Positive').length;
          } catch (err) {
            console.error("Flask API error:", err.message);
          }
        }

        base.positiveReviewCount = positiveCount;
        base.totalReviews = base.reviews.length;
        base.positiveReviewPercentage = base.totalReviews > 0
          ? (positiveCount / base.totalReviews) * 100
          : 0;

        cleanProducts.push(base);
      }

      // ترتيب المنتجات: النسبة المئوية أولاً، ثم عدد التعليقات إذا النسبة متساوية
      cleanProducts.sort((a, b) => {
        if (b.positiveReviewPercentage === a.positiveReviewPercentage) {
          return b.totalReviews - a.totalReviews;
        }
        return b.positiveReviewPercentage - a.positiveReviewPercentage;
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
          { model: shop },
          { model: battery, required: false },
          { model: inverter, required: false },
          { model: solar_panel, required: false },
          {
            model: rating,
            as: 'ratings',
            required: false,
            include: [
              {
                model: account,
                attributes: ['accountId', 'Fname', 'Lname']
              }
            ]
          }
        ]
      });


      if (!Products || Products.length === 0) {
        return { success: false, message: "No products found in your shop." };
      }

      const cleanProducts = [];

      for (const product of Products) {
        const base = {
          productId: product.productId,
          name: product.name ?? null,
          price: product.price ?? null,
          picture: product.picture ?? null,
          category: product.category,
          createdAt: product.createdAt,
          shop: {
            shopId: product.shop?.shopId,
            shopname: product.shop?.shopname,
            phone: product.shop?.phone
          },
          details: {},
          reviews: product.ratings?.map(r => ({
            review: r.review,
            stars: r.stars,
            customer: {
              accountId: r.account?.accountId,
              name: `${r.account?.Fname || ''} ${r.account?.Lname || ''}`.trim(),
              picture:r.account?.profilePic||"null"
            }
          })) || []
        };

        // إضافة تفاصيل حسب الفئة
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

        // تحليل الريفيو
        let positiveCount = 0;
        if (base.reviews.length > 0) {
          try {
            const response = await axios.post("http://localhost:5000/predict", {
              reviews: base.reviews.map(r => r.review)
            });
            const predictions = response.data.predictions;

            positiveCount = predictions.filter(p => p === 'Positive').length;
          } catch (err) {
            console.error("Flask API error:", err.message);
          }
        }

        base.positiveReviewCount = positiveCount;
        base.totalReviews = base.reviews.length;
        base.positiveReviewPercentage = base.totalReviews > 0
          ? (positiveCount / base.totalReviews) * 100
          : 0;

        cleanProducts.push(base);
      }

      // ترتيب المنتجات حسب النسبة المئوية أولاً، ثم عدد التعليقات إذا النسبة متساوية
      cleanProducts.sort((a, b) => {
        if (b.positiveReviewPercentage === a.positiveReviewPercentage) {
          // إذا النسبة متساوية، نرتب حسب عدد التعليقات الكلي
          return b.totalReviews - a.totalReviews;
        }
        // الترتيب الأساسي حسب النسبة المئوية
        return b.positiveReviewPercentage - a.positiveReviewPercentage;
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
  async addReview(userId, review, productId) {
    try {

      const user = await account.findOne({
        where: { accountId: userId },
      });

      if (!user) {
        throw new Error('User not found');
      }


      const Review = await rating.create({
        customerId: userId,
        productId: productId,
        review: review.review,
        stars: review.stars
      });


      return {
        success: true,
        message: 'review added successfully',
        review: Review
      };

    } catch (error) {
      console.error('Error :', error);
      throw error;
    }

  }
};

module.exports = productService;
