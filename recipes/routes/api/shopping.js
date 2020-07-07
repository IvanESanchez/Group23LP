/*
Author: Alex Morse
*/

//External Packages
var express = require("express");

//Project packages
const Ingredient = require('../../models/Ingredient');

var router = express.Router();

//Status code definitions
const success = 200;
const badRequest = 400;
const serverError = 500;

router.post("/add", async (req, res, next) => {
	try {
		//Make sure body exists
		if (req.body == null) {
			//Body was formatted incorrectly, return error badRequest
			res.status(badRequest).json({});
			return;
		}

		//collect information from body
		var user = req.body.userid;
		var ingredients = req.body.ingredients;

		//Make sure information exists
		if (user == null || ingredients == null) {
			//Body was formatted incorrectly, return error badRequest
			res.status(badRequest).json({});
			return;
		}

		for (i = 0; i < ingredients.length; i++) {
			//Check if ingredient exists
			let prev = await Ingredient.findOne({ userid: user, name: ingredients[i].name, unit: ingredients[i].unit });

			if (prev) {
				//Ingredient exists
				prev.amount = prev.amount + ingredients[i].amount;
				await prev.save();
			}
			else {
				//Ingredient does not exist
				ingredient = new Ingredient({ userid: user, name: ingredients[i].name, unit: ingredients[i].unit, amount: ingredients[i].amount });
				await ingredient.save();
			}
		}

		//Return sucess
		res.status(success).json({});
	}
	catch(err) {
		console.log(err.message);
		res.status(serverError).json({});
	}
});

router.post("/remove", async (req, res, next) => {
	try {
		//Make sure body exists
		if (req.body == null) {
			//Body was formatted incorrectly, return error badRequest
			res.status(badRequest).json({});
			return;
		}

		//collect information from body
		var user = req.body.userid;
		var ingredients = req.body.ingredients;

		//Make sure information exists
		if (user == null || ingredients == null) {
			//Body was formatted incorrectly, return error badRequest
			res.status(badRequest).json({});
			return;
		}

		for (i = 0; i < ingredients.length; i++) {
			//Check if ingredient exists
			let prev = await Ingredient.findOne({ userid: user, name: ingredients[i].name, unit: ingredients[i].unit });
			if (prev) {
				if (prev.amount == ingredients[i].amount) {
					//Delete ingredient
					await prev.delete();
				}
				else {
					//Reduce ingredient
					prev.amount = prev.amount - ingredients[i].amount;
					await prev.save();
				}
			}
			else {
				//Ingredient never existed - do nothing
			}
		}

		res.status(success).json({});
	}
	catch(err) {
		console.log(err.message);
		res.status(serverError).json({});
	}
});

router.post("/get", async (req, res, next) => {
	try {
		//Make sure body exists
		if (req.body == null) {
			//Body was formatted incorrectly, return error badRequest
			res.status(badRequest).json({});
			return;
		}

		//collect information from body
		var user = req.body.userid;

		//Make sure information exists
		if (user == null) {
			//Body was formatted incorrectly, return error badRequest
			res.status(badRequest).json({});
			return;
		}

		let list = await Ingredient.find({ userid: user });
		res.status(success).json({ list: list });
	}
	catch (err) {
		console.log(err.message);
		res.status(serverError).json({});
	}
});

module.exports = router;
