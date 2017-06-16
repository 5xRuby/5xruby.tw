import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import Utils from '../shared/utils';
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
          "multiple": false,
          "label": "hihihihihihihihihihi",
          "priority": 0,
          "collection": []
        },
        "e18669d5-0b2f-4ea6-b645-2c2824a95855": {
          "as": "email",
          "name": "email_0",
          "required": true,
          "multiple": false,
          "label": "your email",
          "priority": 1,
          "collection": []
        },
        "e7451554-123d-4507-a170-1f06716ad83b": {
          "as": "check_boxes",
          "name": "check_boxes_0",
          "required": true,
          "multiple": true,
          "label": "skdfkshdfk",
          "priority": 2,
          "collection": ["heyheyhehy", "yoyoyoy", "blablabla"]
        },
      }
    }

    this.getSortedQuestionsArray = this.getSortedQuestionsArray.bind(this);
    this.getTypeCount = this.getTypeCount.bind(this);
    this.handleChangeObject = this.handleChangeObject.bind(this);
    this.handleChangeType = this.handleChangeType.bind(this);
    this.handleNewQuestion = this.handleNewQuestion.bind(this);
    this.handleRemoveQuestion = this.handleRemoveQuestion.bind(this);
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

  handleNewQuestion() {
    const uuid = Utils.generateUUID();
    const stringCount = this.getTypeCount('string');
    const questions = {
      ...this.state.questions,
      [uuid]: {
        as: "string",
        name: `string_${stringCount}`,
        required: false,
        multiple: false,
        label: "",
        priority: this.state.questions.length,
        collection: ["問題選項"]
      }
    }

    this.setState({ questions })
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
      <div>
        <SortableList
          items={sortedQuestionsArray}
          useDragHandle
          onSortEnd={({oldIndex, newIndex}) => {
            this.handleChangeObject(sortedQuestionsArray[oldIndex].id, { priority: sortedQuestionsArray[newIndex].priority })
            this.handleChangeObject(sortedQuestionsArray[newIndex].id, { priority: sortedQuestionsArray[oldIndex].priority })
          }}
          getTypeCount={this.getTypeCount}
          onChangeObject={this.handleChangeObject}
          onChangeType={this.handleChangeType}
          onRemoveQuestion={this.handleRemoveQuestion}
        />
        <div className="text-center">
          <a
            className="btn btn-primary"
            onClick={this.handleNewQuestion}
            style={{width: "30%"}}
          >
            新增問題
          </a>
        </div>
        <input
          name="admin_survey[questions]"
          type="textarea"
          readOnly
          hidden
          value={JSON.stringify(this.state.questions)}
        />
      </div>
    );
  }
}

const SortableList = SortableContainer(({items, getTypeCount, onChangeObject, onChangeType, onRemoveQuestion}) => {
  return (
    <ul className="left-no-padding no-list-style">
      {items.map((obj, index) => (
        <SortableItem
          key={obj.id}
          index={index}
          order={index}
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

const SortableItem = SortableElement(({question, order, getTypeCount, onChangeObject, onChangeType, onRemoveQuestion}) => {
  return (
    <li key={question.id} className="sortable-item gray-border">
      <div className="flex both-padding gray-bg">
        <div className="col-md-1 drag-handle" >
          <DragHandle />
        </div>

        <div className="col-md-10">
          <div className="overflow-hidden bottom-margin-sm text-center" >
            <div className="col-md-1">
              <label htmlFor={`question_${order}_label`}>問題<br/>題目</label>
            </div>
            <div className="col-md-11">
              <input
                id={`question_${order}_label`}
                type="text"
                className="form-control"
                placeholder="問題題目"
                value={question.label}
                onChange={(e) => {
                  onChangeObject(question.id, { label: e.target.value })
                }}
              />
            </div>
          </div>

          <div className="overflow-hidden text-center flex" >
            <div className="col-md-1 vertical-middle">
              <label htmlFor={`question_${order}_type`}>問題<br/>種類</label>
            </div>
            <div className="col-md-10 vertical-middle">
              <select
                id={`question_${order}_type`}
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
                    as: e.target.value,
                    multiple: (newType === "check_boxes")
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

            <div className="col-md-1 vertical-middle">
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
          </div>
        </div>

        <div className="col-md-1 text-center vertical-middle">
          <a
            className="btn btn-danger"
            onClick={() => {
              onRemoveQuestion(question.id)
            }}
          >
            移除
          </a>
        </div>
      </div>

      <QuestionDetail
        question={question}
        onChangeQuestionOption={onChangeObject}
      />
    </li>
  );
})

const QuestionDetail = ({question, onChangeQuestionOption}) => {
  let detail;
  switch(question.as) {
    case 'select':
    case 'radio_buttons':
    case 'check_boxes':
      detail = (
        <div className="flex both-spacing-sm">
          <div className="col-md-offset-1 col-md-10">
            {
              (question.collection || []).map((option, index) =>
                <div key={`${question.id}_q_${index}`} className="flex bottom-spacing-xsm">
                  <div className="col-md-1 text-center vertical-middle">
                    {String.fromCharCode(65 + index)}
                  </div>
                  <div className="col-md-10">
                    <input
                      type="text"
                      className="form-control"
                      placeholder="選項內容"
                      value={option}
                      onChange={(e) => {
                        let collection = [...question.collection];
                        collection[index] = e.target.value;
                        onChangeQuestionOption(question.id, { collection: collection });
                      }}
                    />
                  </div>
                  <div className="col-md-1 text-center vertical-middle">
                    <a
                      onClick={() => {
                        let collection = [...question.collection];
                        collection.splice(index, 1);
                        onChangeQuestionOption(question.id, { collection: collection });
                      }}
                    >
                      <span className="glyphicon glyphicon-trash"></span>
                    </a>
                  </div>
                </div>
              )
            }
          </div>
          <div className="col-md-1 text-center vertical-middle">
            <a
              className="btn btn-primary"
              onClick={() => {
                let collection = [...question.collection];
                collection.push('');
                onChangeQuestionOption(question.id, { collection: collection });
              }}>
              <span className="glyphicon glyphicon-plus"></span>
            </a>
          </div>
        </div>
      );
      break;
    default:
      detail = null;
  }
  return (
    detail
  );
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
