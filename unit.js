const https = require('https');
const assert = require('assert');

const domain = 'www.myrecipebox.club';
const email = 'morse.alex.j@gmail.com'
const username = 'Xela'
const password = 'pass1234'

const msgWorking = 'Unit test: \x1b[36m%s\x1b[0m\t\x1b[34mworking\x1b[0m'
const msgSuccess = '\x1b[1AUnit test: \x1b[36m%s\x1b[0m\t\x1b[32msuccess\x1b[0m'
const msgFailure = 'Status: \x1b[31mfailure\x1b[0m'

var token;

var recipe;
var createdRecipe;

var shoppList = [
	{
		name: 'Milk',
		unit: 'Cups',
		amount: 2
	},
	{
		name: 'Water',
		unit: 'Liters',
		amount: 1
	},
	{
		name: 'Cocao powder',
		unit: 'Grams',
		amount: 5
	}
]

function send(options, call) {
	//Complete options
	if (!options.hostname) {
		options.hostname = domain;
	}
	if (options.body && !options.headers) {
		options.headers = { 'content-type': 'application/json', 'content-length': JSON.stringify(options.body).length };
	}
	if (!options.method) {
		options.method = 'GET';
	}
	if (!options.path) {
		options.path = '/';
	}

	//setup request
	var req = https.request(options, (res) => {
		let data = '';

		//Chunk of data received
		res.on('data', (chunk) => {
			data += chunk;
		});

		//Whole response received
		res.on('end', () => {
			call(data, res.statusCode);
		});

	}).on("error", (err) => {
		console.error("Https request Error: " + err);
		assert.equal(0, 1);
	});

	//Write body
	if (options.body) {
		req.write(JSON.stringify(options.body));
	}
	//Send request
	req.end();
}

function unit_login() {
	//Variables
	const path = '/api/users/login';
	const method = 'POST'
	const input = {
		email: email,
		password: password
	};
	const expect = {
		status: 'success',
		token: "weinvwieunv",	//A string
		data: {
			user: {
    			_id: '5f1664bc5094040017eb77b4',	//A string
    			email: email,
    			name: username,
  			}
		}
	};

	//Log
	console.log(msgWorking, method + ' ' + path + '\t');

	//Test
	send({
		path: path,
		method: method,
		body: input
	}, (res, status) => {
		var data = JSON.parse(res);

		assert.equal(status, 200, msgFailure);
		assert.equal(data.status, expect.status, msgFailure);
		assert.equal(typeof data.token, 'string', msgFailure);
		assert.equal(typeof data.data, 'object', msgFailure);
		assert.equal(typeof data.data.user._id, 'string', msgFailure);
		assert.equal(data.data.user.email, expect.data.user.email, msgFailure);
		assert.equal(data.data.user.name, expect.data.user.name, msgFailure);

		token = data.token;

		console.log(msgSuccess, method + ' ' + path + '\t');

		run();
	});
}
function unit_create_recipe() {
	//Variables
	//Variables
	const path = '/api/recipes'
	const method = 'POST'
	const input = {
		name: 'UNIT_TEST_RECIPE',
		ingredients: [
			{
				name: 'an ingredient',
				unit: 'a unit',
				amount: 10
			},
			{
				name: 'second',
				unit: 'something',
				amount: 16
			}
		],
		directions: 'Do a thing',
	}
	const expect = {
		status: 'success',
		data: {
			recipe: input
		}
	}

	//Log
	console.log(msgWorking, method + ' ' + path + '\t\t');

	//Test
	send({
		path: path,
		method: method,
		body: input,
		headers: {
			'content-type': 'application/json',
			'content-length': JSON.stringify(input).length,
			cookie: 'jwt=' + token
	}}, (res, status) => {
		var data = JSON.parse(res);

		assert.equal(status, 201, msgFailure);
		assert.equal(data.status, expect.status, msgFailure);
		assert.equal(typeof data.data, 'object', msgFailure);
		assert.equal(typeof data.data.recipe, 'object', msgFailure);
		assert.equal(typeof data.data.recipe, 'object', msgFailure);
		assert.equal(typeof data.data.recipe, 'object', msgFailure);
		assert.equal(data.data.recipe.name, expect.data.recipe.name, msgFailure);
		assert.equal(data.data.recipe.ingredients.length, expect.data.recipe.ingredients.length);
		assert.equal(data.data.recipe.ingredients[0].name, expect.data.recipe.ingredients[0].name, msgFailure);
		assert.equal(data.data.recipe.ingredients[0].unit, expect.data.recipe.ingredients[0].unit, msgFailure);
		assert.equal(data.data.recipe.ingredients[0].amount, expect.data.recipe.ingredients[0].amount, msgFailure);
		assert.equal(data.data.recipe.ingredients[1].name, expect.data.recipe.ingredients[1].name, msgFailure);
		assert.equal(data.data.recipe.ingredients[1].unit, expect.data.recipe.ingredients[1].unit, msgFailure);
		assert.equal(data.data.recipe.ingredients[1].amount, expect.data.recipe.ingredients[1].amount, msgFailure);
		assert.equal(data.data.recipe.directions[0], expect.data.recipe.directions, msgFailure);

		createdRecipe = data.data.recipe;

		console.log(msgSuccess, method + ' ' + path + '\t\t');

		run();
	});
}
function unit_update_recipe_by_id() {
	//Variables
	const path = '/api/recipes'
	const method = 'PATCH'
	const input = {
		name: 'NEW_NAME_UNIT_TEST_RECIPE',
		ingredients: [
			{
				name: 'an ingredient',
				unit: 'a unit',
				amount: 10
			},
			{
				name: 'second',
				unit: 'something',
				amount: 16
			}
		],
		directions: 'Do something else',
	}
	const expect = {
		status: 'success',
		data: {
			recipe: input
		}
	}

	//Log
	console.log(msgWorking, method + ' ' + path + '/{recipeID}');

	//Test
	send({
		path: path + '/' + createdRecipe._id,
		method: method,
		body: input,
		headers: {
			'content-type': 'application/json',
			'content-length': JSON.stringify(input).length,
			cookie: 'jwt=' + token
		}
	}, (res, status) => {
		var data = JSON.parse(res);

		assert.equal(status, 200, msgFailure);
		assert.equal(data.status, expect.status, msgFailure);
		assert.equal(typeof data.data, 'object', msgFailure);
		assert.equal(typeof data.data.recipe, 'object', msgFailure);
		assert.equal(typeof data.data.recipe.ingredients, 'object', msgFailure);
		assert.equal(data.data.recipe.ingredients.length, expect.data.recipe.ingredients.length, msgFailure);
		assert.equal(data.data.recipe.ingredients[0].name, expect.data.recipe.ingredients[0].name, msgFailure);
		assert.equal(data.data.recipe.ingredients[0].unit, expect.data.recipe.ingredients[0].unit, msgFailure);
		assert.equal(data.data.recipe.ingredients[0].amount, expect.data.recipe.ingredients[0].amount, msgFailure);
		assert.equal(typeof data.data.recipe.directions, 'object', msgFailure);
		assert.equal(data.data.recipe.directions.length > 0, true, msgFailure);
		assert.equal(data.data.recipe.directions[0], expect.data.recipe.directions, msgFailure);
		assert.equal(data.data.recipe.user, createdRecipe.user, msgFailure);
		assert.equal(data.data.recipe._id, createdRecipe._id, msgFailure);

		createdRecipe = data.data.recipe;

		console.log(msgSuccess, method + ' ' + path + '/{recipeID}');

		run();
	});
}
function unit_get_recipes() {
	//Variables
	const path = '/api/recipes'
	const method = 'GET'
	const expect = {
		status: 'success',
		results: 10,	/*A number*/
		data: {
			recipes: [	/*A list of recipes*/
				{
					ingredients: [	//A list of ingredients
						{
							name: "Scrambled eggs", /*A name*/
							unit: "Cups",			/*A unit*/
							amount: 8,				/*A number*/
						}
					],
					directions: [	/*A list of strings*/
						"Scramble the eggs"			/*A string*/
					],
					user: "eiovhnewionvsw",			/*A string*/
					_id: "fewinviuenbw"				/*A string*/
				}
			]
		}
	}

	//Log
	console.log(msgWorking, method + ' ' + path + '\t\t');

	//Test
	send({
		path: path,
		method: method
	}, (res, status) => {
		var data = JSON.parse(res);

		assert.equal(status, 200, msgFailure);
		assert.equal(data.status, expect.status, msgFailure);
		assert.equal(typeof data.results, 'number', msgFailure);
		assert.equal(typeof data.data, 'object', msgFailure);
		assert.equal(typeof data.data.recipes, 'object', msgFailure);
		assert.equal(data.data.recipes.length > 0, true, msgFailure);
		assert.equal(typeof data.data.recipes[0].ingredients, 'object', msgFailure);
		assert.equal(data.data.recipes[0].ingredients.length > 0, true, msgFailure);
		assert.equal(typeof data.data.recipes[0].ingredients[0].name, 'string', msgFailure);
		assert.equal(typeof data.data.recipes[0].ingredients[0].unit, 'string', msgFailure);
		assert.equal(typeof data.data.recipes[0].ingredients[0].amount, 'number', msgFailure);
		assert.equal(typeof data.data.recipes[0].directions, 'object', msgFailure);
		assert.equal(data.data.recipes[0].directions.length > 0, true, msgFailure);
		assert.equal(typeof data.data.recipes[0].directions[0], 'string', msgFailure);
		assert.equal(typeof data.data.recipes[0].user, 'string', msgFailure);
		assert.equal(typeof data.data.recipes[0]._id, 'string', msgFailure);

		recipe = data.data.recipes[0];

		console.log(msgSuccess, method + ' ' + path + '\t\t');

		run();
	});
}
function unit_get_recipe_by_id() {
	//Variables
	const path = '/api/recipes'
	const method = 'GET'
	const expect = {
		status: 'success',
		data: {
			recipe: recipe
		}
	}

	//Log
	console.log(msgWorking, method + ' ' + path + '/{recipeID}\t');

	//Test
	send({
		path: path + '/' + recipe._id,
		method: method
	}, (res, status) => {
		var data = JSON.parse(res);

		assert.equal(status, 200, msgFailure);
		assert.equal(data.status, expect.status, msgFailure);
		assert.equal(typeof data.data, 'object', msgFailure);
		assert.equal(typeof data.data.recipe, 'object', msgFailure);
		assert.equal(typeof data.data.recipe.ingredients, 'object', msgFailure);
		assert.equal(data.data.recipe.ingredients.length, expect.data.recipe.ingredients.length, msgFailure);
		assert.equal(data.data.recipe.ingredients[0].name, expect.data.recipe.ingredients[0].name, msgFailure);
		assert.equal(data.data.recipe.ingredients[0].unit, expect.data.recipe.ingredients[0].unit, msgFailure);
		assert.equal(data.data.recipe.ingredients[0].amount, expect.data.recipe.ingredients[0].amount, msgFailure);
		assert.equal(typeof data.data.recipe.directions, 'object', msgFailure);
		assert.equal(data.data.recipe.directions.length > 0, true, msgFailure);
		assert.equal(data.data.recipe.directions[0], expect.data.recipe.directions[0], msgFailure);
		assert.equal(data.data.recipe.user, expect.data.recipe.user, msgFailure);
		assert.equal(data.data.recipe._id, expect.data.recipe._id, msgFailure);

		console.log(msgSuccess, method + ' ' + path + '/{recipeID}\t');

		run();
	});
}
function unit_delete_recipe_by_id() {
	//Variables
	const path = '/api/recipes'
	const method = 'DELETE'
	const expect = ''

	//Log
	console.log(msgWorking, method + ' ' + path + '/{recipeID}');

	//Test
	send({
		path: path + '/' + recipe._id,
		method: method,
		headers: {
			'content-type': 'application/json',
			'content-length': 0,
			cookie: 'jwt=' + token
		}
	}, (res, status) => {
		assert.equal(status, 204, msgFailure);
		assert.equal(res, expect, msgFailure);

		console.log(msgSuccess, method + ' ' + path + '/{recipeID}');

		run();
	});
}
function unit_add_to_shopping_list() {
	//Variables
	const path = '/api/shopping'
	const method = 'POST'
	const input = {
		ingredients: shoppList
	}
	const expect = '{}'

	//Log
	console.log(msgWorking, method + ' ' + path + '\t\t');

	//Test
	send({
		path: path,
		method: method,
		body: input,
		headers: {
			'content-type': 'application/json',
			'content-length': JSON.stringify(input).length,
			cookie: 'jwt=' + token
		}
	}, (res, status) => {
		assert.equal(res, expect, msgFailure);

		assert.equal(status, 200, msgFailure);
		console.log(msgSuccess, method + ' ' + path + '\t\t');

		run();
	});
}
function unit_get_shopping_list() {
	//Variables
	const path = '/api/shopping'
	const method = 'GET'
	const expect = {
		list: shoppList
	}

	//Log
	console.log(msgWorking, method + ' ' + path + '\t\t');

	//Test
	send({
		path: path,
		method: method,
		headers: {
			'content-type': 'application/json',
			'content-length': 0,
			cookie: 'jwt=' + token
		}
	}, (res, status) => {
		var data = JSON.parse(res);

		assert.equal(status, 200, msgFailure);
		assert.equal(typeof data.list, 'object', msgFailure);
		assert.equal(data.list.length, expect.list.length, msgFailure);
		for (var i = 0; i < data.list.length; i++) {
			assert.equal(data.list[i].name, expect.list[i].name, msgFailure);
			assert.equal(data.list[i].unit, expect.list[i].unit, msgFailure);
			assert.equal(data.list[i].amount, expect.list[i].amount, msgFailure);
		}

		console.log(msgSuccess, method + ' ' + path + '\t\t');

		run();
	});
}
function unit_delete_from_shopping_list() {
	//Variables
	const path = '/api/shopping';
	const method = 'DELETE';
	const input = {
		ingredients: shoppList
	}
	const expect = '{}';

	//Log
	console.log(msgWorking, method + ' ' + path + '\t\t');

	//Test
	send({
		path: path,
		method: method,
		body: input,
		headers: {
			'content-type': 'application/json',
			'content-length': JSON.stringify(input).length,
			cookie: 'jwt=' + token
		}
	}, (res, status) => {
		assert.equal(status, 200, msgFailure);
		assert.equal(res, expect, msgFailure);

		console.log(msgSuccess, method + ' ' + path + '\t\t');

		run();
	});
}
function unit_create_calendar() {
	//Variables
	const path = '/api/calendar';
	const method = 'POST';
	const expect = {
		calendar: {
			_id: 'ewinvbwuinebwegijwneobi',	//A string
			name: username + ' Calendar\'s',
			userid: 'ewoibnrieunbruebneewg'	//A string
		}
	};

	//Log
	console.log(msgWorking, method + ' ' + path + '\t\t');

	//Test
	send({
		path: path,
		method: method,
		headers: {
			'content-type': 'application/json',
			'content-length': 0,
			cookie: 'jwt=' + token
		}
	}, (res, status) => {
		var data = JSON.parse(res);

		assert.equal(status, 200, msgFailure);
		assert.equal(typeof data.calendar, 'object', msgFailure);
		assert.equal(typeof data.calendar._id, 'string', msgFailure);
		assert.equal(data.calendar.name, expect.calendar.name, msgFailure);
		assert.equal(typeof data.calendar.userid, 'string', msgFailure);

		console.log(msgSuccess, method + ' ' + path + '\t\t');

		run();
	});
}
function unit_add_to_calendar() {
	//Variables
	const path = '/api/calendar/addToCalendar';
	const method = 'POST';
	const input = {
		recipe: [
			{
				name: "Scrambled Eggs",
				ingredients: [
					{
						name: "Sugar",
						unit: "Cups",
						amount: 2
					}
				],
				directions: "Scramble the eggs"
			}
		]
	}
	const expect = '{}'

	//Log
	console.log(msgWorking, method + ' ' + path);

	//Test
	send({
		path: path,
		method: method,
		body: input,
		headers: {
			'content-type': 'application/json',
			'content-length': JSON.stringify(input).length,
			cookie: 'jwt=' + token
		}
	}, (res) => {
		assert.equal(res, expect, msgFailure);

		console.log(msgSuccess, method + ' ' + path);

		run();
	});
}

//List of unit tests to run
const tests = [
	unit_login,
	unit_create_recipe,
	unit_update_recipe_by_id,
	unit_get_recipes,
	unit_get_recipe_by_id,
	unit_delete_recipe_by_id,
	unit_add_to_shopping_list,
	unit_get_shopping_list,
	unit_delete_from_shopping_list,
	unit_create_calendar,
	unit_add_to_calendar
]
var curr = 0;

function run() {
	if (curr >= tests.length) {
		console.log();
		console.log("Unit tests \x1b[32mcomplete\x1b[0m");
	}
	else {
		tests[curr]();
		curr++;
	}
}
run();
