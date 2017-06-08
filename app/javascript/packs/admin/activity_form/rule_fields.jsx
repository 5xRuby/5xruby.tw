import React from 'react';
import RuleTr from './rule_tr';
import {SortableContainer, SortableElement} from 'react-sortable-hoc';

const RuleFields = ({rulesArray, activityCoursesArray, onChangeObject, onRemove, onNew}) => (
  <div>
    <table className="table">
      <thead>
        <tr>
          <th>順序</th>
          <th>講座組合</th>
          <th>行銷文字</th>
          <th>價格</th>
          <th>早鳥優惠</th>
          <th></th>
        </tr>
      </thead>
      <SortableList
        items={rulesArray}
        useDragHandle
        onSortEnd={({oldIndex, newIndex}) => {
          onChangeObject(rulesArray[oldIndex].id, { priority: rulesArray[newIndex].priority })
          onChangeObject(rulesArray[newIndex].id, { priority: rulesArray[oldIndex].priority })
        }}
        activityCoursesArray={activityCoursesArray}
        onChangeObject={onChangeObject}
        onRemove={onRemove}
      />
    </table>
    <a
      className="btn btn-block btn-success"
      onClick={onNew}
    >
      新增規則
    </a>
  </div>
);

const SortableList = SortableContainer(({items, activityCoursesArray, onChangeObject, onRemove}) => {
  return (
    <tbody>
      {items.map((rule, index) => (
        <SortableItem
          key={'item-'.concat(rule.id).concat(index)}
          index={index}
          obj={rule}
          activityCoursesArray={activityCoursesArray}
          onChangeObject={onChangeObject}
          onRemove={onRemove}
        />
      ))}
    </tbody>
  );
});

const SortableItem = SortableElement(({obj, activityCoursesArray, onChangeObject, onRemove}) =>
  <RuleTr
    key={obj.id}
    rule={obj}
    activityCoursesArray={activityCoursesArray}
    onChangeObject={(changeSet) => {
      onChangeObject(obj.id, changeSet);
    }}
    onRemove={() => {
      onRemove(obj.id);
    }}
  />
);

export default RuleFields;
