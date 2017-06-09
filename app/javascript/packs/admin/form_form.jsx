import React from 'react';
import ReactDOM from 'react-dom';


class FormFormFields extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      questions: props.questions
    };
  }

  render () {
    return(
      null
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('form_fields');
  const data = Object.assign({}, node.dataset);

  // each value in data object must be converted into an array
  Object.keys(data).map(id => data[id] = JSON.parse(data[id]));

  ReactDOM.render(<FormFormFields {...data}/>, node);
})
