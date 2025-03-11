module.exports = (sequelize, DataTypes) => {
    const account = sequelize.define('account', {
        accountId: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        Fname: {
            type: DataTypes.STRING
        },
        Lname: {
            type: DataTypes.STRING
        },
        email: {
            type: DataTypes.STRING
        },
        phone: {
            type: DataTypes.INTEGER
        },
        password: {
            type: DataTypes.STRING
        },
        country: {
            type: DataTypes.STRING
        },
        type: {
            type: DataTypes.STRING
        }
    });

    return account;
}