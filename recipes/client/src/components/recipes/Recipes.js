import React, { Fragment, useEffect } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import RecipeItem from './RecipeItem';
import RecipeForm from './RecipeForm';
import { getRecipes } from '../../actions/recipe';

const Recipes = ({ getRecipes, recipe: { recipes } }) => {
  useEffect(() => {
    getRecipes();
  }, [getRecipes]);

  return (
    <Fragment>
      <h1 className="large text-primary">Recipes</h1>
      <p className="lead">
        <i className="fas fa-user" /> Welcome to the community
      </p>
      <RecipeForm />
      <div className="recipes">
        {recipes.map((recipe) => (
          <RecipeItem key={recipe._id} recipe={recipe} />
        ))}
      </div>
    </Fragment>
  );
};

Recipes.propTypes = {
  getRecipes: PropTypes.func.isRequired,
  recipe: PropTypes.object.isRequired
};

const mapStateToProps = (state) => ({
  recipe: state.recipe
});

export default connect(mapStateToProps, { getRecipes })(Recipes);
