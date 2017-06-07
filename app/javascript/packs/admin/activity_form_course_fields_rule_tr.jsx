import React from 'react';
import Select from 'react-select';
import _ from 'lodash';

export default class ActivityFormCourseFieldsRuleTr extends React.Component {
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

    return (
      <tr>
        <td className="col-md-2">
          <Select
            multi
            simpleValue
            joinValues
            clearable
            delimiter=","
            value={rule.selectedActivityCourseIDs}
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
                  onChangeObject({ price: e.target.value });
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
              value={rule.early_price}
              onChange={(e) => {
                if (onChangeObject) {
                  onChangeObject({ early_price: e.target.value });
                }
              }}
            />
          </div>
        </td>
        <td className="col-md-2">
          <div className="input-group">
            <span className="input-group-addon">#</span>
            <input
              className="form-control"
              type="number"
              step="1"
              min="0"
              value={rule.priority}
              onChange={(e) => {
                if (onChangeObject) {
                  onChangeObject({ priority: e.target.value });
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
    let diff;
    let newVals = oldVals;

    if(oldVals.length < vals.length) {
      diff = _.difference(vals, oldVals).pop()
      newVals.push(diff)
    } else {
      diff = _.difference(oldVals, vals).pop()
      newVals.splice(oldVals.indexOf(diff), 1)
    }
    callback( { newVals } );
  }
}

