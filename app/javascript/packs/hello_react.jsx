import React from 'react'
import ReactDOM from 'react-dom'

class Hello extends React.Component {
  render() {
    const { a } = this.props;

    return(
      <div>Hello, {a}</div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('activity_form_rule_fields')
  const data = node.dataset

  ReactDOM.render(<Hello {...data}/>, node)
})
