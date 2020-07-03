import React, { useState } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { addRecipe } from '../../actions/recipe';

const RecipeForm = ({ addRecipe }) => {
  const [text, setText] = useState('');

  return (
    <div className='recipe-form'>
      <div className='bg-primary p'>
        <h3>Add a recipe to the community...</h3>
      </div>
      <form
        className='form my-1'
        onSubmit={e => {
          e.preventDefault();
          addRecipe({ text });
          setText('');
        }}
      >
        <textarea
          name='text'
          cols='30'
          rows='5'
          placeholder='Create recipe'
          value={text}
          onChange={e => setText(e.target.value)}
          required
        />
        <input type='submit' className='btn btn-dark my-1' value='Submit' />
      </form>
    </div>
  );
};

RecipeForm.propTypes = {
  addRecipe: PropTypes.func.isRequired
};

export default connect(
  null,
  { addRecipe }
)(RecipeForm);
