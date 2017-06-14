import React from 'react';
import ActivityCourseTr from './activity_course_tr';
import {SortableContainer, SortableElement} from 'react-sortable-hoc';

const NewActivityCourseButton = (props) => {

  if (props.hasActivityCourse) {
    return(
      <a
        className="btn btn-block btn-success"
        onClick={props.onNew}
      >
        新增課程
      </a>
    );
  } else {
    return(null);
  }
}


const ActivityCourseFields = ({activityCoursesArray, courseSelectOptions, onChangeObject, onRemove, onNew, isCamp}) => (
  <div>
    <table id="activity_courses" className="table">
      <thead>
        <tr>
          <th>順序</th>
          <th>#</th>
          <th>課程內容</th>
          <th>價格</th>
          <th></th>
        </tr>
      </thead>
      <SortableList
        items={activityCoursesArray}
        useDragHandle
        onSortEnd={({oldIndex, newIndex}) => {
          onChangeObject(activityCoursesArray[oldIndex].id, { priority: activityCoursesArray[newIndex].priority })
          onChangeObject(activityCoursesArray[newIndex].id, { priority: activityCoursesArray[oldIndex].priority })
        }}
        courseSelectOptions={courseSelectOptions}
        onChangeObject={onChangeObject}
        onRemove={onRemove}
      />
    </table>
    <NewActivityCourseButton
      hasActivityCourse={
        isCamp || activityCoursesArray.length === 0
      }
    />
  </div>
);

const SortableList = SortableContainer(({items, courseSelectOptions, onChangeObject, onRemove}) => {
  return (
    <tbody>
      {items.map((activityCourse, index) => (
        <SortableItem
          key={'item-'.concat(activityCourse.id)}
          index={index}
          order={index}
          obj={activityCourse}
          courseSelectOptions={courseSelectOptions}
          onChangeObject={onChangeObject}
          onRemove={onRemove}
        />
      ))}
    </tbody>
  );
});

const SortableItem = SortableElement(({obj, order, courseSelectOptions, onChangeObject, onRemove}) =>
  <ActivityCourseTr
    key={obj.id}
    order={order}
    activityCourse={obj}
    courseSelectOptions={courseSelectOptions}
    onChangeObject={(changeSet) => {
      onChangeObject(obj.id, changeSet);
    }}
    onRemove={() => {
      onRemove(obj.id);
    }}
  />
);

export default ActivityCourseFields;
