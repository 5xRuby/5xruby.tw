import React from 'react';
import ActivityCourseTr from './activity_course_tr';

const ActivityCourseFields = ({activityCoursesArray, courseSelectOptions, onChangeObject, onRemove, onNew}) => (
  <div>
    <table id="activity_courses" className="table">
      <thead>
        <tr>
          <th>#</th>
          <th>課程內容</th>
          <th>價格</th>
          <th>順序</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        {activityCoursesArray.map((activityCourse, index) => {
          return (
            <ActivityCourseTr
              key={activityCourse.id}
              index={index}
              activityCourse={activityCourse}
              courseSelectOptions={courseSelectOptions}
              onChangeObject={(changeSet) => {
                onChangeObject(activityCourse.id, changeSet);
              }}
              onRemove={() => {
                onRemove(activityCourse.id);
              }}
            />
          );
        })}
      </tbody>
    </table>
    <a
      className="btn btn-block btn-success"
      onClick={onNew}
    >
      新增課程
    </a>
  </div>
);

export default ActivityCourseFields;
