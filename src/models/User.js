const mongoose = require('mongoose');
const Schema = mongoose.Schema;


const UserSchema = new Schema ({
    
    Username: String,
    Password: String,
    FactorA: String,
    Type: String,
    Email: String,
    Image: String,
}, { collection: 'User' });

module.exports = mongoose.model('User', UserSchema);
