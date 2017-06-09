import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import './survey_form/style';


class SurveyFormQuestionsFields extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      questions: {
        "e7451554-15cc-4507-a170-1f06716ad83b": {
          "as": "string",
          "name": "string_1",
          "required": true,
          "multiple":false,
          "label": "hihihihihihihihihihi",
          "priority": 0
        },
        "e18669d5-0b2f-4ea6-b645-2c2824a95855": {
          "as": "email",
          "name": "email_1",
          "required": true,
          "multiple": false,
          "label": "your email",
          "priority": 1
        }
      }
    }
  }

  questionTypeCount = (type) => {
    let typeCount = _.reduce(this.props.questions, (total, el) => {
      return total + (el.as === type ? 1 : 0)
    }, 0);

    return typeCount;
  }

  getSortedQuestionsArray = () => {
    const compare = (a, b) => {
      if (a.priority < b.priority) {
        return -1;
      } else if (b.priority < a.priority) {
        return 1;
      }

      return 0;
    }

    const questionsArray = Object.keys(this.state.questions).map( id => ({
      ...this.state.questions[id],
      id: id
    }));

    return questionsArray.sort(compare);
  }

  onChangeObject = (questionID, changeSet) => {
    const questions = {
      ...this.state.questions,
      [questionID]: {
        ...this.state.questions[questionID],
        ...changeSet
      }
    }

    this.setState({ questions })
  }

  render () {
    const questions = this.state.questions;
    const sortedQuestionsArray = this.getSortedQuestionsArray();
    const questionTypeSelectOptions = [
      ['單行文字', 'string'],
      ['Email', 'email'],
      ['URL', 'url'],
      ['電話號碼', 'tel'],
      ['多行文字', 'text'],
      ['檔案上傳', 'file'],
      ['拉下選單', 'select'],
      ['單選核取方塊', 'radio_buttons'],
      ['多選核取方塊', 'check_boxes']
    ];

    return(
      <div className="container">
        <ul className="no-padding-left no-list-style">
          {sortedQuestionsArray.map((obj, index) => (
            <li key={obj.id}>
              <div className="row">
                <div className="col-md-3">
                  <select
                    className="select required form-control"
                    label="false"
                    value={obj.as}
                    onChange={(e) => {
                      const newVal = `${e.target.value}_${this.questionTypeCount(e.target.value) + 1}`
                      this.onChangeObject(obj.id, { name: newVal, as: e.target.value });
                    }}
                  >
                    {questionTypeSelectOptions.map( q =>
                      <option
                        key={`${q[1]}_${this.questionTypeCount(q[1])}`}
                        value={`${q[1]}`}
                      >
                        {q[0]}
                      </option>
                    )}
                  </select>
                </div>
                <div className="col-md-1">{obj.required}</div>
                <div className="col-md-6">{obj.label}</div>
                <div className="col-md-2">
                  <a
                    className="btn btn-default"
                    onClick={() => {
                      this.handleRemoveQuestion()
                    }}
                  >
                    移除
                  </a>
                </div>
              </div>
            </li>
          ))}
        </ul>
      </div>
    );
  }

  handleRemoveQuestion = () => {
    return; // TODO
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('survey_fields');
  if (node) {
    const data = Object.assign({}, node.dataset);

    // each value in data object must be converted into an array
    Object.keys(data).map(id => data[id] = JSON.parse(data[id]));

    ReactDOM.render(<SurveyFormQuestionsFields {...data}/>, node);
  }
})
