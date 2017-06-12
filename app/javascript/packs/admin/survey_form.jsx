import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import DragHandle from './drag_handle';
import {SortableContainer, SortableElement} from 'react-sortable-hoc';

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

class SurveyFormQuestionsFields extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      questions: {
        "e7451554-15cc-4507-a170-1f06716ad83b": {
          "as": "string",
          "name": "string_0",
          "required": true,
          "multiple":false,
          "label": "hihihihihihihihihihi",
          "priority": 0
        },
        "e18669d5-0b2f-4ea6-b645-2c2824a95855": {
          "as": "email",
          "name": "email_0",
          "required": true,
          "multiple": false,
          "label": "your email",
          "priority": 1
        }
      }
    }

    this.getSortedQuestionsArray = this.getSortedQuestionsArray.bind(this);
    this.getTypeCount = this.getTypeCount.bind(this);
    this.handleChangeObject = this.handleChangeObject.bind(this);
    this.handleChangeType = this.handleChangeType.bind(this);
    this.handleRemoveQuestion = this.handleChangeObject.bind(this);
  }

  componentWillMount() {
    let typesCount = {}
    questionTypeSelectOptions.map((item) => {
      typesCount[item[1]] = 0;
    })

    typesCount = _.reduce(this.state.questions, (obj, el) => {
      obj[el.as] = obj[el.as] + 1
      return obj
    }, typesCount);

    this.setState({ typesCount });
  }

  getSortedQuestionsArray() {
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

  getTypeCount(type) {
    const count = this.state.typesCount[type];
    return count;
  }

  handleChangeObject(questionID, changeSet) {
    const questions = {
      ...this.state.questions,
      [questionID]: {
        ...this.state.questions[questionID],
        ...changeSet
      }
    }

    this.setState({ questions })
  }

  handleChangeType(oldType, newType) {
    const typesCount = {
      ...this.state.typesCount,
      [oldType]: this.state.typesCount[oldType] - 1,
      [newType]: this.state.typesCount[newType] + 1
    }

    this.setState({ typesCount })
  }

  handleRemoveQuestion(questionID) {
    const questions = {
      ...this.state.questions
    };
    delete questions[questionID]

    this.setState({ questions });
  }

  render () {
    const questions = this.state.questions;
    const sortedQuestionsArray = this.getSortedQuestionsArray();

    return(
      <div className="container">
        <ol className="no-padding-left">
          <SortableList
            items={sortedQuestionsArray}
            onSortEnd={({oldIndex, newIndex}) => {
              this.handleChangeObject(sortedQuestionsArray[oldIndex].id, { priority: sortedQuestionsArray[newIndex].priority })
              this.handleChangeObject(sortedQuestionsArray[newIndex].id, { priority: sortedQuestionsArray[oldIndex].priority })
            }}
            getTypeCount={this.getTypeCount}
            onChangeObject={this.handleChangeObject}
            onChangeType={this.handleChangeType}
            onRemoveQuestion={this.handleRemoveQuestion}
          />
        </ol>
      </div>
    );
  }
}

const SortableList = SortableContainer(({items, getTypeCount, onChangeObject, onChangeType, onRemoveQuestion}) => {
  return (
    <ul className="no-padding-left no-list-style">
      {items.map((obj, index) => (
        <SortableItem
          key={obj.id}
          index={index}
          question={obj}
          getTypeCount={getTypeCount}
          onChangeObject={onChangeObject}
          onChangeType={onChangeType}
          onRemoveQuestion={onRemoveQuestion}
        />
      ))}
    </ul>
  );
})

const SortableItem = SortableElement(({question, getTypeCount, onChangeObject, onChangeType, onRemoveQuestion}) => {
  return (
    <li key={question.id}>
      <div className="row">
        <div className="col-md-1">
          <DragHandle />
        </div>

        <div className="form-group col-md-3">
          <label>問題種類</label>
          <select
            className="select required form-control"
            label="false"
            value={question.as}
            onChange={(e) => {
              const oldType = question.as;
              const newType = e.target.value;
              const newVal = `${newType}_${getTypeCount(newType)}`;

              onChangeType(oldType, newType);
              onChangeObject(question.id, {
                name: newVal,
                as: e.target.value
              });
            }}
          >
            {questionTypeSelectOptions.map( q =>
              <option
                key={`${q[1]}_${getTypeCount(q[1]) + 1}`}
                value={`${q[1]}`}
              >
                {q[0]}
              </option>
            )}
          </select>
        </div>

        <div className="col-md-1">
          <label>
            <input
              type="checkbox"
              checked={question.required}
              onChange={(e) => {
                onChangeObject(question.id, { required: e.target.checked })
              }}
            />
            必填
          </label>
        </div>

        <div className="form-group col-md-5">
          <label>問題題目</label>
          <input
            type="text"
            className="form-control"
            placeholder="問題題目"
            value={question.label}
            onChange={(e) => {
              onChangeObject(question.id, { label: e.target.value })
            }}
          />
        </div>

        <div className="col-md-2">
          <a
            className="btn btn-default"
            onClick={() => {
              onRemoveQuestion(obj.id)
            }}
          >
            移除
          </a>
        </div>
      </div>
    </li>
  );
})

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('survey_fields');
  if (node) {
    const data = Object.assign({}, node.dataset);

    // each value in data object must be converted into an array
    Object.keys(data).map(id => data[id] = JSON.parse(data[id]));

    ReactDOM.render(<SurveyFormQuestionsFields {...data}/>, node);
  }
})
