import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import Utils from '../shared/utils';
import ActivityCourseFields from './activity_form/activity_course_fields';
import RuleFields from './activity_form/rule_fields';

class ActivityFormCourseFields extends React.Component {
  constructor(props, context) {
    super(props, context);

    this.state = {
      activityCourses: {},
      rules: {}
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
    const activityCourses = _.reduce(this.props.activityCourses, (o, i) => {
      o[i.id] = i;
      return o;
    }, {});

    // Convert rule to an object
    const rules = _.reduce(this.props.rules, (obj, value, key) => {
      const uuid = Utils.generateUUID();
      obj[uuid] = {
        ...value,
        selectedActivityCourseIDs: key.split("--")
      }
      return obj
    }, {})

    // fetch activity type and bind on change
    this.bindActivityType();

    this.setState({ activityCourses, rules });
  }

  bindActivityType() {
    const $input = $('#admin_activity_type');
    const update = ($input) => {
      this.setState( { isCamp: $input.val() === "Activity::Camp" } )
    }
    update($input);

    $input.on('change', (e) => {
      update($(e.target))
    });
  }

  render() {
    const { courseSelectOptions } = this.props;
    const activityCoursesArray = this.getSortedActivityCoursesArray();
    const rulesArray = this.getSortedRulesArray();

    return (
      <div>
        <ActivityCourseFields
          activityCoursesArray={activityCoursesArray}
          courseSelectOptions={courseSelectOptions}
          onChangeObject={(activityCourseID, changeSet) => {
            this.handleActivityCourseChange(activityCourseID, changeSet);
          }}
          onRemove={(activityCourseID) => {
            this.handleRemoveActivityCourse(activityCourseID);
          }}
          onNew={() => {
            this.handleNewActivityCourse()
          }}
          isCamp={this.state.isCamp}
        />

        <RuleFields
          rulesArray={rulesArray}
          activityCoursesArray={activityCoursesArray}
          onChangeObject={(ruleID, changeSet)=> {
            this.handleRuleChange(ruleID, changeSet);
          }}
          onRemove={(ruleID) => {
            this.handleRemoveRule(ruleID);
          }}
          onNew={() => {
            this.handleNewRule()
          }}
        />

        <input
          name="admin_activity[rules]"
          hidden
          type="textarea"
          value={JSON.stringify(this.getActivityRuleInputValue())}
        />
      </div>
    );
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
    const rulesArray = Object.keys(this.state.rules).map(id => ({
      ...this.state.rules[id],
      id: id
    }));

    return rulesArray.sort(Utils.compare);
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
    const uuid = Utils.generateUUID();
    const priority = this.getSortedActivityCoursesArray().filter((o) => !o._destroy).length
    const activityCourses = {
      ...this.state.activityCourses,
      [uuid]: {
        _new: true,
        id: uuid,
        priority,
        price: 10000
      }
    };

    this.setState({ activityCourses });
  }

  handleNewRule() {
    const id = Utils.generateUUID();
    const priority = this.getSortedRulesArray().length;
    const rules = {
      ...this.state.rules,
      [id]: {
        selectedActivityCourseIDs: [],
        priority,
        price: 10000,
        early_bird_price: 10000
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
    const activityCourseIDs = Object.keys(this.state.activityCourses)

    return Object.keys(this.state.rules).map((id) => this.state.rules[id]).reduce((result, el) => {
      const uuid = el.selectedActivityCourseIDs.
        filter((el) => $.inArray(el, activityCourseIDs) >= 0).
        sort().
        join("--")
      result[uuid] = {
        ...el
      }
      return result
    }, {})
  }
}

class ActivityFormDetailFields {
  constructor() {
    this.$typeInput = $("select[name='admin_activity[type]']");
    this.bindInput(this.$typeInput);
    this.setupTrigger();
  }

  bindInput(input) {
    if (input.val() == "Activity::Camp") {
      for (var el of $('.camp-only')) {
        $(el).show();
      }
    } else {
      for (var el of $('.camp-only')) {
        $(el).hide();
      }
    }
  }

  setupTrigger() {
    this.$typeInput.on('change', (e) => {
      this.bindInput($(e.target))
    })
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('activity_form_rule_fields');
  if (node) {
    const data = Object.assign({}, node.dataset);

    // each value in data object must be converted into an array
    Object.keys(data).map(id => data[id] = JSON.parse(data[id]));

    ReactDOM.render(<ActivityFormCourseFields {...data}/>, node);

    ActivityFormDetailFields = new ActivityFormDetailFields;
  }
})
