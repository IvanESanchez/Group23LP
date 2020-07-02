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
		//Body was formatted incorrectly, return error code 400
		res.status(400).json({});
		return;
	}

	//Collect information from body
	var username = req.body.username;
	var password = req.body.password;
	var email = req.body.email;

	//Make sure body info exists
	if (username == null || password == null || email == null) {
		//Body was formatted incorrectly, return error code 400
		res.status(400).json({});
		return;
	}

	if (!doesUserExist(username, email)) {
		//User doesn't exists, create a new one.
		createUser(username, password, email);
	}
	else {
		//User exists, return error code 409
		res.status(409).json({});
		return;
	}

	res.status(200).json({});
});

function attemptLogin(username, password) {
	return "1";
}
function createNewSession(ip, userid) {
	return "1";
}
router.post("/login", async (req, res, next) => {
	//Make sure body exists
	if (req.body == null) new Promise(function(resolve, reject) {
		//Body was formatted incorrectly, return error code 400
		res.status(400).json({});
		return;
	});

	var username = req.body.username;
	var password = req.body.password;

	//Make sure body info exists
	if (username == null || password == null) {
		//Body was formatted incorrectly, return error code 400
		res.status(400).json({});
		return;
	}

	var login = attemptLogin(username, password);
	var session;
	if (login != "") {
		//Login successful, create new session
		session = createNewSession(req.ip, login);
	}
	else {
		//Login failed, return error code 409
		res.status(409).json({});
		return;
	}

	var ret = {id:session};
	res.status(200).json(ret);
});

module.exports = router;
