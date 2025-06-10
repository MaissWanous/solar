
module.exports=(sequelize, DataTypes)=>{
async function createDatabase() {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');

        await sequelize.query("CREATE DATABASE IF NOT EXISTS solar");
        console.log('Database created or already exists.');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    } finally {
        await sequelize.close();
    }
}
}
