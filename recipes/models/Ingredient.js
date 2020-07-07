const mongoose = require('mongoose');

const IngredientSchema = new mongoose.Schema({
	userid: {
		type: Number,
		required: true
	},
    name: {
        type: String,
        required: true
    },
    unit: {
        type: String,
        required: true,
        unique: true
    },
	amount: {
		type: Number,
		required: true
	}
});

module.exports = mongoose.model('ingredient', IngredientSchema);
