import React from 'react';

export default class ActivityCourseTrSelect extends React.Component {
  render() {
    return (
      <select
        className="select required form-control"
        label="false"
        name={this.props.name}
        value={this.props.value}
        onChange={this.props.onChange}
      >
        {this.props.courseSelectOptions.map(
          option => <option key={option[1]} value={option[1]}>{option[0]}</option>
        )}
      </select>
    );
  }
}
