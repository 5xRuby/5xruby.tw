import React from 'react';
import ReactDOM from 'react-dom';
import ActivityFormCourseFieldsActivityCourseTr from './activity_form_course_fields_activity_course_tr';
import ActivityFormCourseFieldsRuleTr from './activity_form_course_fields_rule_tr';

class ActivityFormCourseFields extends React.Component {
  constructor(props, context) {
    super(props, context);

    const rules = {} // TODO

    this.state = {
      activityCourses: {},
      rules
    };

    this.handleActivityCourseChange = this.handleActivityCourseChange.bind(this);
    this.handleNewActivityCourse = this.handleNewActivityCourse.bind(this);
    this.handleRemoveActivityCourse = this.handleRemoveActivityCourse.bind(this);
    this.handleRuleChange = this.handleRuleChange.bind(this);
    this.handleNewRule = this.handleNewRule.bind(this);
    this.handleRemoveRule = this.handleRemoveRule.bind(this);
  }

  componentWillMount() {
    // Reduce activityCourses to an object
    const activityCourses = this.props.activityCourses.reduce((o, i) => {
      o[i.id] = i;
      return o;
    }, {});

    this.setState({ activityCourses });
  }

  render() {
    const { courseSelectOptions } = this.props;

    const activityCoursesArray = this.getSortedActivityCoursesArray();
    return (
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
                <ActivityFormCourseFieldsActivityCourseTr
                  key={activityCourse.id}
                  index={index}
                  activityCourse={activityCourse}
                  courseSelectOptions={courseSelectOptions}
                  onChangeObject={(changeSet) => {
                    this.handleActivityCourseChange(activityCourse.id, changeSet);
                  }}
                  onRemove={() => {
                    this.handleRemoveActivityCourse(activityCourse.id);
                  }}
                />
              );
            })}
          </tbody>
        </table>
        <a
          className="btn btn-block btn-success"
          onClick={this.handleNewActivityCourse}
        >
          新增課程
        </a>

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
            {this.getSortedRulesArray().map(rule => {
              return (
                <ActivityFormCourseFieldsRuleTr
                  key={rule.id}
                  activityCoursesArray={activityCoursesArray}
                  rule={rule}
                  onChangeObject={(changeSet) => {
                    this.handleRuleChange(rule.id, changeSet);
                  }}
                  onRemove={() => {
                    this.handleRemoveRule(rule.id);
                  }}
                />
              )
            })}
          </tbody>
        </table>
        <a
          className="btn btn-block btn-success"
          onClick={this.handleNewRule}
        >
          新增規則
        </a>
        <input
          name="admin_activity[rules]"
          type="textarea"
          value={JSON.stringify(this.getActivityRuleInputValue())}
        />
      </div>
    );
  }

  generateUUID() {
    const s4 = () => Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
  }

  getSortedActivityCoursesArray() {
    const compare = (a, b) => {
      if (b._destroy && !a._destroy) {
        return -1;
      } else if (a._destroy && !b._destroy) {
        return 1;
      } else if (a.priority < b.priority) {
        return -1;
      } else if (b.priority < a.priority) {
        return 1;
      }

      return 0;
    }

    const activityCoursesArray = Object.keys(this.state.activityCourses).map(id => this.state.activityCourses[id]);

    return activityCoursesArray.sort(compare);
  }

  getSortedRulesArray() {
    const compare = (a, b) => {
      if (a.priority < b.priority) {
        return -1;
      } else if (b.priority < a.priority) {
        return 1;
      }

      return 0;
    }

    const rulesArray = Object.keys(this.state.rules).map(id => ({
      ...this.state.rules[id],
      id: id
    }));

    return rulesArray.sort(compare);
  }

  handleActivityCourseChange(activityCourseID, newData) {
    const activityCourses = {
      ...this.state.activityCourses,
      [activityCourseID]: {
        ...this.state.activityCourses[activityCourseID],
        ...newData
      }
    };

    this.setState({ activityCourses });
  }

  handleRuleChange(ruleID, newData) {
    const rules = {
      ...this.state.rules,
      [ruleID]: {
        ...this.state.rules[ruleID],
        ...newData
      }
    };
    this.setState({ rules });

  }

  handleNewActivityCourse() {
    const uuid = this.generateUUID();
    const priority = this.getSortedActivityCoursesArray().filter((o) => !o._destroy).length + 1;
    const activityCourses = {
      ...this.state.activityCourses,
      [uuid]: {
        _new: true,
        id: uuid,
        priority,
        price: 100000
      }
    };

    this.setState({ activityCourses });
  }

  handleNewRule() {
    const id = this.generateUUID();
    const priority = this.getSortedRulesArray().length + 1;
    const rules = {
      ...this.state.rules,
      [id]: {
        selectedActivityCourseIDs: [],
        priority,
        price: 100000,
        early_price: 100000
      }
    };

    this.setState({ rules });
  }

  handleRemoveActivityCourse(id) {
    const activityCourse = this.state.activityCourses[id];
    if (!activityCourse) return;

    let activityCourses;

    if (activityCourse._new) {
      activityCourses = {
        ...this.state.activityCourses
      };

      delete activityCourses[id];
    } else {
      activityCourses = {
        ...this.state.activityCourses,
        [id]: {
          ...activityCourse,
          _destroy: true
        }
      };
    }

    this.setState({ activityCourses });
  }

  handleRemoveRule(id) {
    let rules = {
      ...this.state.rules
    }

    delete rules[id]

    this.setState({ rules });
  }

  getActivityRuleInputValue() {
    const activityCoursesIDs = Object.keys(this.state.activityCourses)

    return Object.keys(this.state.rules).map((id) => this.state.rules[id]).reduce((result, el) => {
      const uuid = el.selectedActivityCourseIDs.
        filter((el) => $.inArray(el, activityCoursesIDs) >= 0).
        sort().
        join("--")
      result[uuid] = el
      return result
    }, {})
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('activity_form_rule_fields');
  const data = Object.assign({}, node.dataset);

  // each value in data object must be converted into an array
  Object.keys(data).map(id => data[id] = JSON.parse(data[id]));

  ReactDOM.render(<ActivityFormCourseFields {...data}/>, node);
})
