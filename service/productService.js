const { battery, inverter, solar_panel, products, shop, sequelize } = require("../models");

const productService = {
    async addProduct(productData, additionalData) {
        try {
            const transaction = await sequelize.transaction();
            const product = await products.create(productData, { transaction });

            if (productData.category === "battery") {
                await battery.create({ productId: product.productId, ...additionalData }, { transaction });
            } else if (productData.category === "inverter") {
                await inverter.create({ productId: product.productId, ...additionalData }, { transaction });
            } else if (productData.category === "solar_panel") {
                await solar_panel.create({ productId: product.productId, ...additionalData }, { transaction });
            }

            await transaction.commit();
            return product;
        } catch (err) {
            await transaction.rollback();
            throw err;
        }
    },

    async getMyProduct(user) {
        try {
            console.log(user);

            const myProducts = await products.findAll({
                include: [{
                    model: shop,
                    where: { shopKeeperId: user.accountId }
                }]
            });

            return myProducts;
        } catch (err) {
            console.error("خطأ أثناء جلب المنتجات:", err);
            throw err;
        }
    }
};

module.exports = productService;