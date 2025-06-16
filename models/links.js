module.exports = (sequelize, DataTypes) => {
  const account = require("./account")(sequelize, DataTypes);
  const links = sequelize.define("links", {
    linkId: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    linkUserId: {
      type: DataTypes.INTEGER,
      references: {
        model: account, // Reference the imported account model
        key: "accountId", // Foreign key in the account table
      },
    },
    linkName: {
      type: DataTypes.STRING,
    },
    link: {
      type: DataTypes.STRING,
    },
  });

  return links;
};
