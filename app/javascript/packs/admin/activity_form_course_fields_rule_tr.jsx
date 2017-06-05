import React from 'react';

export default class ActivityFormCourseFieldsRuleTr extends React.Component {
  render() {
    const {
      activityCoursesArray,
      rule,
      onChangeObject,
      onRemove
    } = this.props;

    return (
      <tr>
        <td>
          {activityCoursesArray.filter(o => !o._destroy).map((activityCourse, index) => {
            return (
              <div>
                <input
                  type="checkbox"
                  checked={$.inArray(activityCourse.id, rule.selectedActivityCourseIDs) >= 0}
                  onChange={(e) => {
                    if (!onChangeObject) return;

                    let selectedActivityCourseIDs = rule.selectedActivityCourseIDs;
                    if(e.target.checked) {
                      selectedActivityCourseIDs.push(activityCourse.id)
                    } else {
                      index = rule.selectedActivityCourseIDs.indexOf(activityCourse.id)
                      selectedActivityCourseIDs.splice(index, 1)
                    }

                    onChangeObject( { selectedActivityCourseIDs } )
                  }}
                />
                {String.fromCharCode(65 + index)}
              </div>
            )
          })
          }
        </td>
        <td>
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
        <td>
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
        <td>
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
        <td>
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
        <td>
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
}

