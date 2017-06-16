import React from 'react';
import Select from 'react-select';
import _ from 'lodash';
import DragHandle from '../drag_handle';

export default class RuleTr extends React.Component {
  constructor(props) {
    super(props);

    this.handleSelectValues = this.handleSelectValues.bind(this);
  }

  render() {
    const {
      activityCoursesArray,
      rule,
      onChangeObject,
      onRemove
    } = this.props;

    const options = activityCoursesArray.filter(o => !o._destroy).map((activityCourse, index) => ({
      label: String.fromCharCode(65 + index),
      value: activityCourse.id
    }));

    const value = activityCoursesArray.filter(o => {
      return !o._destroy && rule.selectedActivityCourseIDs.indexOf(o.id) >= 0
    }).map(o => o.id)

    return (
      <tr>
        <td className="col-md-1">
          <DragHandle />
        </td>
        <td className="col-md-2">
          <Select
            multi
            simpleValue
            joinValues
            clearable
            delimiter=","
            value={value}
            options={options}
            onChange={vals => {
              const newSelectedActivityCourseIDs = vals.split(",").filter(o => o)
              this.handleSelectValues(rule.selectedActivityCourseIDs, newSelectedActivityCourseIDs, onChangeObject);
            }}
          />
        </td>
        <td className="col-md-3">
          <input
            className="form-control"
            value={rule.writing}
            onChange={(e) => {
              if (onChangeObject) {
                onChangeObject({ writing: e.target.value });
              }
            }}
          />
        </td>
        <td className="col-md-2">
          <div className="input-group">
            <span className="input-group-addon">NT$</span>
            <input
              className="form-control"
              type="number"
              step="1"
              min="0"
              value={rule.price}
              onChange={(e) => {
                if (onChangeObject) {
                  onChangeObject({ price: parseInt(e.target.value) });
                }
              }}
            />
          </div>
        </td>
        <td className="col-md-2">
          <div className="input-group">
            <span className="input-group-addon">NT$</span>
            <input
              className="form-control"
              type="number"
              step="1"
              min="0"
              value={rule.early_bird_price}
              onChange={(e) => {
                if (onChangeObject) {
                  onChangeObject({ early_bird_price: parseInt(e.target.value) });
                }
              }}
            />
          </div>
        </td>
        <td className="col-md-1">
          <a
            className="btn btn-default"
            onClick={() => {
              if (onRemove) onRemove();
            }}
          >
            移除
          </a>
        </td>
      </tr>
    );
  }

  handleSelectValues(oldVals, vals, callback) {
    let el;
    let newVals = oldVals;

    if(oldVals.length < vals.length) {
      el = _.difference(vals, oldVals).pop()
      newVals.push(el)
    } else {
      el = _.difference(oldVals, vals).pop()
      newVals.splice(oldVals.indexOf(el), 1)
    }
    callback( { selectedCourses: newVals } );
  }
}

