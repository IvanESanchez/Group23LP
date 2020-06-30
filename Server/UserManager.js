/*
Author: Alex Morse
Date created: 6 / 30 / 2020
*/

var express = require("express");
var router = express.Router();

router.post("/register",  async (req, res, next) => {
	console.log(req.body);

	//TODO

	var ret = {message:"Done"};
	res.status(200).json(ret);
});

router.post("/login", async (req, res, next) => {
	console.log(req.body);

	//TODO

	var ret = {message:"Done"};
	res.status(200).json(ret);
});

module.exports = router;
