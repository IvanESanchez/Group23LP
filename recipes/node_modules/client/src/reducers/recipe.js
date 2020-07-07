import {
  GET_RECIPES,
  POST_ERROR,
  UPDATE_LIKES,
  DELETE_RECIPE,
  ADD_RECIPE,
  GET_RECIPE,
  ADD_COMMENT,
  REMOVE_COMMENT
} from '../actions/types';

const initialState = {
  recipes: [],
  recipe: null,
  loading: true,
  error: {}
};

export default function(state = initialState, action) {
  const { type, payload } = action;

  switch (type) {
    case GET_RECIPES:
      return {
        ...state,
        recipes: payload,
        loading: false
      };
    case GET_RECIPE:
      return {
        ...state,
        recipe: payload,
        loading: false
      };
    case ADD_RECIPE:
      return {
        ...state,
        recipes: [payload, ...state.recipes],
        loading: false
      };
    case DELETE_RECIPE:
      return {
        ...state,
        recipes: state.recipes.filter(recipe => recipe._id !== payload),
        loading: false
      };
    case POST_ERROR:
      return {
        ...state,
        error: payload,
        loading: false
      };
    case UPDATE_LIKES:
      return {
        ...state,
        recipes: state.recipes.map(recipe =>
          recipe._id === payload.id ? { ...recipe, likes: payload.likes } : recipe
        ),
        loading: false
      };
    case ADD_COMMENT:
      return {
        ...state,
        recipe: { ...state.recipe, comments: payload },
        loading: false
      };
    case REMOVE_COMMENT:
      return {
        ...state,
        recipe: {
          ...state.recipe,
          comments: state.recipe.comments.filter(
            comment => comment._id !== payload
          )
        },
        loading: false
      };
    default:
      return state;
  }
}
