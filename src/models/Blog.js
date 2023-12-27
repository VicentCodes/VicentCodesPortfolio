const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// En tu modelo
const BlogSchema = new Schema ({
    Title: String,
    Description: String,
    Date: String,
    Image: String,
    Tag: String,
    Content: String,
}, { collection: 'Blog' });

module.exports = mongoose.model('Blog', BlogSchema);
