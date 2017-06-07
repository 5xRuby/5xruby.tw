import React from 'react';
import RuleTr from './rule_tr';

const RuleFields = ({rulesArray, activityCoursesArray, onChangeObject, onRemove, onNew}) => (
  <div>
    <table className="table">
      <thead>
        <tr>
          <th>講座組合</th>
          <th>行銷文字</th>
          <th>價格</th>
          <th>早鳥優惠</th>
          <th>順序</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        {rulesArray.map(rule => {
          return (
            <RuleTr
              key={rule.id}
              activityCoursesArray={activityCoursesArray}
              rule={rule}
              onChangeObject={(changeSet) => {
                onChangeObject(rule.id, changeSet);
              }}
              onRemove={() => {
                onRemove(rule.id);
              }}
            />
          )
        })}
      </tbody>
    </table>
    <a
      className="btn btn-block btn-success"
      onClick={onNew}
    >
      新增規則
    </a>
  </div>
);

export default RuleFields;
