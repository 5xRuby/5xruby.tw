import React from 'react';
import ActivityFormCourseFieldsCourseSelect from './activity_form_course_fields_course_select';

export default class ActivityFormCourseFieldsActivityCourseTr extends React.Component {
  render() {
    const {
      index,
      activityCourse,
      courseSelectOptions,
      onChangeObject,
      onRemove
    } = this.props;

    if (activityCourse._destroy) {
      return (
        <tr>
          <input type="hidden" value={activityCourse.id} name={`admin_activity[activity_courses_attributes][${index}][id]`} />
          <input type="hidden" value="1" name={`admin_activity[activity_courses_attributes][${index}][_destroy]`} />
        </tr>
      );
    }
    return (
      <tr>
        <input type="hidden" value={activityCourse.id} name={`admin_activity[activity_courses_attributes][${index}][id]`} />
        <td>{String.fromCharCode(65 + index)}.</td>
        <td>
          <ActivityFormCourseFieldsCourseSelect
            name={`admin_activity[activity_courses_attributes][${index}][course_id]`}
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
              name={`admin_activity[activity_courses_attributes][${index}][price]`}
              type="number"
              step="1"
              min="0"
              value={activityCourse.price}
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
            <span className="input-group-addon">#</span>
            <input
              className="form-control"
              name={`admin_activity[activity_courses_attributes][${index}][priority]`}
              type="number"
              step="1"
              min="0"
              value={activityCourse.priority}
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
