import React from 'react';
import ReactDOM from 'react-dom';
import Utils from './shared/utils';
import _ from 'lodash';

class CampRegistrationForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      activityCourses: {},
      courseEnrollments: {},
      rules: props.rules
    }

    this.handleClickActivityCourse = this.handleClickActivityCourse.bind(this);
  }

  componentWillMount() {
    // map activityCourses
    let activityCourses = Object.assign({}, this.props.activityCourses)

    Object.keys(activityCourses).map((key, i) =>
      activityCourses[key] = {
        ...activityCourses[key],
        price: parseInt(activityCourses[key].price)
    })

    // initialize courseEnrollments
    let courseEnrollments = {}
    Object.keys(activityCourses).map(id =>
      courseEnrollments[id] = false
    )

    this.setState({ activityCourses, courseEnrollments })
  }

  getSortedActivityCoursesArray() {
    const array = Object.keys(this.state.activityCourses).map(id => this.state.activityCourses[id]);

    return array.sort(Utils.compare);
  }

  getCourseEnrollmentsArray() {
    const array = Object.keys(_.pickBy(this.state.courseEnrollments, value => value))
    return array
  }

  getSortedRulesArray() {
    const array = Object.keys(this.state.rules).map(id => ({
      ...this.state.rules[id],
      id: id
    }));

    return array.sort(Utils.compare);
  }

  getMatchedRuleID() {
    const courseEnrollments = this.getCourseEnrollmentsArray();
    const qualifiedRules = Object.keys(this.state.rules).
      filter(ruleID => ruleID.split("--").every(id => courseEnrollments.indexOf(id) > -1))

    if (qualifiedRules.length == 0) {
      return '';
    } else if (qualifiedRules.length == 1) {
      return qualifiedRules[0];
    } else {
      let discount = 0;

      return qualifiedRules.reduce((id, ruleID) => {
        const rule = this.state.rules[ruleID];
        const specialPriceRulePart = rule['price'];
        const specialPriceExtraPart = this.calOriginalPrice(
          courseEnrollments.
            filter(id => rule['selectedActivityCourseIDs'].indexOf(id) < 0).
            filter(id => rule['freeActivityCourseIDs'].indexOf(id) < 0)
        )
        const specialPrice = specialPriceRulePart + specialPriceExtraPart;
        const originalPrice = this.calOriginalPrice(courseEnrollments);
        const currentDiscount = originalPrice - specialPrice;

        if (currentDiscount > discount) {
          discount = currentDiscount;
          return ruleID;
        } else if (currentDiscount == discount) {
          if (!id) {
            return ruleID;
          } else {
            return ruleID.split("--").length > id.split("--").length ? ruleID : id
          }
        } else {
          return id;
        }
      }, '');
    }
  }

  calOriginalPrice(ids) {
    return _.reduce(this.state.activityCourses, (sum, value, key) => {
      if (_.includes(ids, key)) {
        return sum + parseInt(value.price)
      }

      return sum
    }, 0)
  }

  calTotalPrice() {
    const matchedID = this.getMatchedRuleID();
    const rule = this.state.rules[matchedID];
    const courseEnrollments = this.getCourseEnrollmentsArray();

    if (matchedID) {
      const rulePriceExtraPart = this.calOriginalPrice(
        courseEnrollments.
          filter(id => rule['selectedActivityCourseIDs'].indexOf(id) < 0).
          filter(id => rule['freeActivityCourseIDs'].indexOf(id) < 0)
      );
      const rulePrice = rule['price'];

      return rulePrice + rulePriceExtraPart;
    } else {
      return this.calOriginalPrice(courseEnrollments);
    }
  }

  handleClickActivityCourse(id, isClicked) {
    const courseEnrollments = {
      ...this.state.courseEnrollments,
      [id]: isClicked
    }

    this.setState({ courseEnrollments })
  }

  render() {
    const activityCoursesArray = this.getSortedActivityCoursesArray();
    const rulesArray = this.getSortedRulesArray();

    return (
      <div className="col-xs-12 col-md-8 center-block top-spacing-lg">
        <h2 className="title text-center">票卷資訊</h2>

        <hr/>

        <div className="overflow-hidden activity-courses rl-padding-lg">
          <ol className="no-list-style">
            {activityCoursesArray.map(item => (
              <li key={item.id}>
                <div className="col-xs-9 col-md-9">
                  {item.title}
                </div>

                <div className="col-xs-2 col-md-2">
                  {parseInt(item.price)}
                </div>

                <div className="col-xs-1 col-md-1">
                  <input
                    type="checkbox"
                    onChange={(e) => {
                      this.handleClickActivityCourse(item.id, e.target.checked)
                    }}
                  />
                </div>
              </li>
            ))}
          </ol>
        </div>

        <div className="rule-container top-padding rl-padding-lg">
          <div className="info text-right">根據不同選擇有不同優惠</div>

          <ul className="left-no-padding no-list-style">
            {rulesArray.map(item => (
              <li
                key={item.id}
                className={item.id == this.getMatchedRuleID() ? "bingo" : undefined}
              >
                <div className="col-xs-8 col-md-8">
                  {item.writing}
                </div>

                <div className="col-xs-2 col-md-2">
                  原價 {this.calOriginalPrice(item.selectedActivityCourseIDs.concat(item.freeActivityCourseIDs))}
                </div>

                <div className="col-xs-2 col-md-2">
                  特價 {item.price}
                </div>
              </li>
            ))}
          </ul>

          <div className="info text-right">以上優惠專案皆附有D.Git課程</div>
        </div>

        <div className="total-price">
          <h3>共計 <span className="price">{this.calTotalPrice()} 元</span></h3>
        </div>

        <input
          readOnly
          hidden
          value={JSON.stringify(this.getCourseEnrollmentsArray())}
          name="order[course_enrollments]"
        />

        <input
          hidden
          readOnly
          value={this.getMatchedRuleID()}
          name="order[rule_id]"
        />
      </div>
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.querySelectorAll('.camp-registration #form')[0]

  if (node) {
    const data = Object.assign({}, node.dataset);
    Object.keys(data).map(id => data[id] = JSON.parse(data[id]));

    ReactDOM.render(<CampRegistrationForm {...data}/>, node);
  }
})
