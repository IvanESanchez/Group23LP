/*
Author: Alex Morse
Date created: 6 / 30 / 2020
*/

const MongoClient = require("mongodb").MongoClient;
const assert = require("assert");

//Login credentials
//Replace *** with actual data
const username = "***"
const password = "***"
const cluster = "***", database = "***", userCol = "***"

//Connection URL
const uri = "mongodb+srv://" + username + ":" + password + "@" + cluster + "-u1eml.mongodb.net/<dbname>?retryWrites=true&w=majority";

//Init mongo
exports.client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });
exports.client.connect(mongoMain);

function mongoMain(err) {
	assert.equal(null, err);
	console.log("Connected to database");

	exports.users = exports.client.db(database).collection(userCol);

	//collection.insertOne(one, insertComplete);		//Inserts a single document into the database.
	//collection.insertMany(many, insertComplete);		//Inserts multiple documents into the database.

	//collection.updateOne(oneFrom, {$set: oneTo}, updateComplete);			//Updates only one document matching the filter from the database.
	//collection.updateMany(manyFrom, {$set: manyTo}, updateComplete);		//Updates every document matching the filter from the database.

	//collection.deleteOne(oneRemove, deleteComplete);		//Deletes only one document matching filter from the database.
	//collection.deleteMany(manyRemove, deleteComplete);	//Deletes every document matching the filter from the database,

	//nextCursor = collection.find(findSample).limit(2);				//Creates a cursor pointing to the results of the search for the first 2 elements matching findSample.
	//nextCursor.next(findCompleteNext);								//According to the mongoDB tutorial, this is the recommended way to use find() and is more efficient than toArray()/forEach()
}
