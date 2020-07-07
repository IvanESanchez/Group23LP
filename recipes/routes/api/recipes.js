const express = require('express');
const router = express.Router();
const { check, validationResult } = require('express-validator');
const auth = require('../../middleware/auth');

const Recipe = require('../../models/Recipe');
const User = require('../../models/User');
const checkObjectId = require('../../middleware/checkObjectId');

// @route    POST api/recipes
// @desc     Create a recipe
// @access   Private
router.post(
    '/',
    [auth, [check('text', 'Text is required').not().isEmpty()]],
    async (req, res) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({ errors: errors.array() });
        }

        try {
            const user = await User.findById(req.user.id).select('-password');

            const newRecipe = new Recipe({
                text: req.body.text,
                name: user.name,
                user: req.user.id
            });

            const recipe = await newRecipe.save();

            res.json(recipe);
        } catch (err) {
            console.error(err.message);
            res.status(500).send('Server Error');
        }
    }
);

// @route    GET api/recipes
// @desc     Get all recipes
// @access   Private
router.get('/', auth, async (req, res) => {
    try {
        const recipes = await Recipe.find().sort({ date: -1 });  //date : 1 for oldest first
        res.json(recipes);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

// @route    GET api/recipes/:id
// @desc     Get recipe by ID
// @access   Private
router.get('/:id', [auth, checkObjectId('id')], async (req, res) => {
    try {
        const recipe = await Recipe.findById(req.params.id);

        if (!recipe) {
            return res.status(404).json({ msg: 'Recipe not found' })
        }

        res.json(recipe);
    } catch (err) {
        console.error(err.message);

        res.status(500).send('Server Error');
    }
});

// @route    DELETE api/recipes/:id
// @desc     Delete a recipe
// @access   Private
router.delete('/:id', [auth, checkObjectId('id')], async (req, res) => {
    try {
        const recipe = await Recipe.findById(req.params.id);

        if (!recipe) {
            return res.status(404).json({ msg: 'Recipe not found' });
        }

        // Check user
        if (recipe.user.toString() !== req.user.id) {
            return res.status(401).json({ msg: 'User not authorized' });
        }

        await recipe.remove();

        res.json({ msg: 'Recipe removed' });
    } catch (err) {
        console.error(err.message);

        res.status(500).send('Server Error');
    }
});

// @route    PUT api/recipes/like/:id
// @desc     Like a recipe
// @access   Private
router.put('/like/:id', [auth, checkObjectId('id')], async (req, res) => {
    try {
        const recipe = await Recipe.findById(req.params.id);

        // Check if the recipe has already been liked
        if (recipe.likes.some(like => like.user.toString() === req.user.id)) {
            return res.status(400).json({ msg: 'Recipe already liked' });
        }

        // could push but unshift puts it on the beginning
        recipe.likes.unshift({ user: req.user.id });

        await recipe.save();

        return res.json(recipe.likes);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

// @route    PUT api/recipes/unlike/:id
// @desc     Unlike a recipe
// @access   Private
router.put('/unlike/:id', [auth, checkObjectId('id')], async (req, res) => {
    try {
        const recipe = await Recipe.findById(req.params.id);

        // Check if the recipe has not yet been liked
        if (!recipe.likes.some(like => like.user.toString() === req.user.id)) {
            return res.status(400).json({ msg: 'Recipe has not yet been liked' });
        }

        // remove the like
        recipe.likes = recipe.likes.filter(
            ({ user }) => user.toString() !== req.user.id
        );

        await recipe.save();

        return res.json(recipe.likes);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server Error');
    }
});

// @route    POST api/recipes/comment/:id
// @desc     Comment on a recipe
// @access   Private
router.post(
    '/comment/:id',
    [
        auth,
        checkObjectId('id'),
        [check('text', 'Text is required').not().isEmpty()]
    ],
    async (req, res) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({ errors: errors.array() });
        }

        try {
            const user = await User.findById(req.user.id).select('-password');
            const recipe = await Recipe.findById(req.params.id);

            const newComment = {
                text: req.body.text,
                name: user.name,
                user: req.user.id
            };

            recipe.comments.unshift(newComment);

            await recipe.save();

            res.json(recipe.comments);
        } catch (err) {
            console.error(err.message);
            res.status(500).send('Server Error');
        }
    }
);

// @route    DELETE api/recipes/comment/:id/:comment_id
// @desc     Delete comment
// @access   Private
router.delete('/comment/:id/:comment_id', auth, async (req, res) => {
    try {
        const recipe = await Recipe.findById(req.params.id);

        // Pull out comment
        const comment = recipe.comments.find(
            comment => comment.id === req.params.comment_id
        );
        // Make sure comment exists
        if (!comment) {
            return res.status(404).json({ msg: 'Comment does not exist' });
        }
        // Check user
        if (comment.user.toString() !== req.user.id) {
            return res.status(401).json({ msg: 'User not authorized' });
        }

        recipe.comments = recipe.comments.filter(
            ({ id }) => id !== req.params.comment_id
        );

        await recipe.save();

        return res.json(recipe.comments);
    } catch (err) {
        console.error(err.message);
        return res.status(500).send('Server Error');
    }
});

module.exports = router;
