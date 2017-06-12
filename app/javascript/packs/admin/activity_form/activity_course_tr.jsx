import React from 'react';
import ActivityCourseTrSelect from './activity_course_tr_select';
import DragHandle from '../drag_handle';

export default class ActivityCourseTr extends React.Component {
  render() {
    const {
      order,
      activityCourse,
      courseSelectOptions,
      onChangeObject,
      onRemove
    } = this.props;

    if (activityCourse._destroy) {
      return (
        <tr>
          <input type="hidden" value={activityCourse.id} name={`admin_activity[activity_courses_attributes][${order}][id]`} />
          <input type="hidden" value="1" name={`admin_activity[activity_courses_attributes][${order}][_destroy]`} />
        </tr>
      );
    }
    return (
      <tr>
        <input type="hidden" value={activityCourse.id} name={`admin_activity[activity_courses_attributes][${order}][id]`} />
        <td>
          <DragHandle />
        </td>
        <td>{String.fromCharCode(65 + order)}</td>
        <td>
          <ActivityCourseTrSelect
            name={`admin_activity[activity_courses_attributes][${order}][course_id]`}
            courseSelectOptions={courseSelectOptions}
            value={activityCourse.course_id}
            onChange={(e) => {
              if (onChangeObject) {
                onChangeObject({ course_id: e.target.value });
              }
            }}
          />
        </td>
        <td>
          <div className="input-group">
            <span className="input-group-addon">NT$</span>
            <input
              className="form-control"
              name={`admin_activity[activity_courses_attributes][${order}][price]`}
              type="number"
              step="1"
              min="0"
              value={activityCourse.price}
              onChange={(e) => {
                if (onChangeObject) {
                  onChangeObject({ price: parseInt(e.target.value) });
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
