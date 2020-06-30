/*
Author: Alex Morse
Date created: 6 / 30 / 2020
*/

//External packages
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

//Project packages
const userManager = require("./UserManager.js");
const mongo = require("./MongoHandler.js");

//Express setup
const app = express();
app.use(cors());
app.use(bodyParser.json());

app.use((req, res, next) => {
	res.setHeader('Access-Control-Allow-Origin', '*');
	res.setHeader(
		'Access-Control-Allow-Headers',
		'Origin, X-Requested-With, Content-Type, Accept, Authorization'
	);
	res.setHeader(
    	'Access-Control-Allow-Methods',
    	'GET, POST, PATCH, DELETE, OPTIONS'
	);
	next();
});

app.use("/UserManager", userManager);

//Start server on port 5000
app.listen(5000, () => {
	console.log(`Server listening on port 5000.`);
});
