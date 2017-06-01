class ActivityFormCourseFields extends React.Component {
  constructor(props, context) {
    super(props, context);

    // Reduce activityCourses to an object
    const activityCourses = this.props.activityCourses.reduce((o, i) => {
      o[i.id] = i;
      return o;
    }, {});

    this.state = {
      activityCourses,
      rules: this.props.rules
    };

    this.handleActivityCourseChange = this.handleActivityCourseChange.bind(this);
    this.handleNewActivityCourse = this.handleNewActivityCourse.bind(this);
    this.handleRemoveActivityCourse = this.handleRemoveActivityCourse.bind(this);
  }

  render() {
    const {
      courseSelectOpions
    } = this.props;

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
            {this.getSortedActivityCoursesArray().map((activityCourse, index) => {
              return (
                <ActivityFormCourseFieldsActivityCourseTr
                  key={activityCourse.id}
                  index={index}
                  activityCourse={activityCourse}
                  courseSelectOpions={courseSelectOpions}
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
}

class ActivityFormCourseFieldsActivityCourseTr extends React.Component {
  render() {
    const {
      index,
      activityCourse,
      courseSelectOpions,
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
            courseSelectOpions={courseSelectOpions}
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

class ActivityFormCourseFieldsCourseSelect extends React.Component {
  render() {
    return (
      <select
        className="select required form-control"
        label="false"
        name={this.props.name}
        value={this.props.value}
        onChange={this.props.onChange}
      >
        {this.props.courseSelectOpions.map(
          option => <option key={option[1]} value={option[1]}>{option[0]}</option>
        )}
      </select>
    );
  }
}
