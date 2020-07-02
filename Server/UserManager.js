/*
Author: Alex Morse
Date created: 6 / 30 / 2020
*/

//Project packages
const mongo = require("./MongoHandler.js");

var express = require("express");
var router = express.Router();

function doesUserExist(username, email) {
	return false;
}
function createUser(username, password, email) {

}
router.post("/register",  async (req, res, next) => {
	//Make sure body exists
	if (req.body == null) {

	}

	//Collect information from body
	var username = req.body.username;
	var password = req.body.password;
	var email = req.body.email;

	//Make sure body info exists
	if (username == null || password == null || email == null) {
		//Body was formatted incorrectly, return error code 400
		res.status(400);
	}

	if (!doesUserExist(username, email)) {
		createUser(username, password, email);
	}

	res.status(200);
});

router.post("/login", async (req, res, next) => {
	console.log(req.body);

	//TODO

	var ret = {message:"Done"};
	res.status(200).json(ret);
});

module.exports = router;
