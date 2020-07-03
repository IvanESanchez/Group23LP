import React, { Fragment, useEffect } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';
import Spinner from '../layout/Spinner';
import RecipeItem from '../recipes/RecipeItem';
import CommentForm from '../recipe/CommentForm';
import CommentItem from '../recipe/CommentItem';
import { getRecipe } from '../../actions/recipe';

const Recipe = ({ getRecipe, recipe: { recipe, loading }, match }) => {
  useEffect(() => {
    getRecipe(match.params.id);
  }, [getRecipe, match.params.id]);

  return loading || recipe === null ? (
    <Spinner />
  ) : (
    <Fragment>
      <Link to="/recipes" className="btn">
        Back To Recipes
      </Link>
      <RecipeItem recipe={recipe} showActions={false} />
      <CommentForm recipeId={recipe._id} />
      <div className="comments">
        {recipe.comments.map((comment) => (
          <CommentItem key={comment._id} comment={comment} recipeId={recipe._id} />
        ))}
      </div>
    </Fragment>
  );
};

Recipe.propTypes = {
  getRecipe: PropTypes.func.isRequired,
  recipe: PropTypes.object.isRequired
};

const mapStateToProps = (state) => ({
  recipe: state.recipe
});

export default connect(mapStateToProps, { getRecipe })(Recipe);
