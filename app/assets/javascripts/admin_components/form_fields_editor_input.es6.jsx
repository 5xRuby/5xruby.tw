const AVAILABLE_FIELDS_AS = [
  ['單行文字', 'string'],
  ['Email', 'email'],
  ['URL', 'url'],
  ['電話號碼', 'tel'],
  ['使用者的 Email', 'email_from_current_user'],
  ['使用者的電話', 'phone_from_current_user'],
  ['使用者的姓名', 'username_from_current_user'],
  ['多行文字', 'text'],
  ['檔案上傳', 'file'],
  ['拉下選單', 'select'],
  ['單選核取方塊', 'radio_buttons'],
  ['多選核取方塊', 'check_boxes']
];

class FormFieldsEditorInput extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: (typeof props.value === 'string' ? JSON.parse(props.value) : props.value) || []
    };

    this.multiple_fields = ['check_boxes'];
    this.available_fields_as_cnt = {};
    this.field_as_select_options = AVAILABLE_FIELDS_AS.map(
      (text_value_as, key) => {
        this.available_fields_as_cnt[text_value_as[1]] = 0
        return <option key={key} value={text_value_as[1]}>{ text_value_as[0] }</option>
      }
    )
    this.state.value.forEach(
      (field) => {
        let
          as_cnt_from_field = field.name.split('_')[1],
          current_as_cnt = this.available_fields_as_cnt[field.as];
        if(as_cnt_from_field > current_as_cnt)
          this.available_fields_as_cnt[field.as] = as_cnt_from_field
      }
    )
  }
  render () {
    return (
      <div className="form-fields-editor inside-horizontal-form">
        <textarea name={ this.props.name } value={ JSON.stringify(this.state.value) } style={{display: 'none'}} readOnly='true' />
        { this.renderFieldTypeSelect() }
        <hr />
        { this.state.value.map(
            (field, index) => {
              if(field === undefined) return;
              let field_editor;
              switch(field.as) {
                case 'string':
                case 'email':
                case 'url':
                case 'tel':
                case 'email_from_current_user':
                case 'username_from_current_user':
                case 'phone_from_current_user':
                case 'text':
                  field_editor = (
                    <div>
                      <div className="form-group">
                        <label>問題題目</label>
                        <input type="text" className="form-control" placeholder="問題題目"
                          value={field.label} onChange={this.genOnChangeHandler(index, 'label')} />
                      </div>
                    </div>
                  )
                  break;
                case 'file':
                  field_editor = (
                    <div>
                      <div className="form-group">
                        <label>上傳說明</label>
                        <input type="text" className="form-control" placeholder="上傳說明"
                          value={field.label} onChange={this.genOnChangeHandler(index, 'label')} />
                      </div>
                    </div>
                  )
                  break;
                case 'select':
                case 'radio_buttons':
                case 'check_boxes':
                  field_editor = (
                    <div>
                      <div className="form-group">
                        <label>問題題目</label>
                        <input type="text" className="form-control" placeholder="問題題目"
                          value={field.label} onChange={this.genOnChangeHandler(index, 'label')} />
                      </div>
                      <div className="form-group">
                        <label>選項
                        </label>
                        <div>
                          {
                            (field.collection || []).map((option, option_index) =>
                              <div className="options-inputs col-xs-12 col-md-6" key={option_index}>
                                <div className="input-group">
                                  <input type="text" className="form-control" placeholder="選項內容"
                                    value={option} onChange={this.genOnOptionChangeHandler(index, option_index)} />
                                  <span className="input-group-btn">
                                    <a className="btn btn-danger" onClick={this.genRmOptionHandler(index, option_index)}>刪除這個選項</a>
                                  </span>
                                </div>
                              </div>
                            )
                          }
                          <div className="options-inputs col-xs-12 col-md-6">
                            <a className="btn btn-primary btn-block" onClick={this.genAddOptionHandler(index)}>增加選項</a>
                          </div>
                        </div>
                      </div>
                    </div>
                  )
                  break;
                default:
                  field_editor = (
                    <div>
                      <h3>Unknown field type (as: {field.as})</h3>
                    </div>
                  )
              }
              return (
                <div key={index}>
                  <div className="form-group">
                    <div className="row">
                      <div className="col-xs-8">
                        { this.renderFieldTypeSelect(index, field.as) }
                      </div>
                      <div className="col-xs-2">
                        <div className="checkbox">
                          <label>
                            <input type="checkbox" checked={field.required} onChange={this.genOnChangeHandler(index, 'required', (e) => e.target.checked)} />
                            必填
                          </label>
                        </div>
                      </div>
                      <div className="col-xs-2">
                        <a className="btn btn-danger btn-block" onClick={this.genRmFieldHandler(index)}>刪除這個問題</a>
                      </div>
                    </div>
                  </div>
                  { field_editor }
                  { index === this.state.value.length - 1 ? null : <hr /> }
                </div>
              );
            }
        ) }
      </div>
    );
  }
  renderFieldTypeSelect(index = false, value = '0') {
    return (
      <select className="form-control" onChange={ index === false ? this.genAddFieldHandler() : this.genFieldTypeSelectChangeHandler(index) } value={value}>
        { index === false ? <option key='0'>新增欄位</option> : '' }
        { this.field_as_select_options }
      </select>
    )
  }

  genAddFieldHandler() {
    return (e) => {
      let
        newValue = this.state.value.slice(),
        as = e.target.value;
      newValue.push({
        as: as,
        name: this.newFieldName(as),
        required: false,
        multiple: this.multiple_fields.indexOf(as) >= 0
      });
      this.setState({value: newValue});
    }
  }
  genFieldTypeSelectChangeHandler(index) {
    return (e) => {
      this.changeValue(index, 'as', e.target.value);
      this.changeValue(index, 'multiple', this.multiple_fields.indexOf(e.target.value) >= 0);
    }
  }
  genRmFieldHandler(index) {
    return (e) => {
      if(!confirm("你確定？")) return;
      let newValue = this.state.value.slice();
      newValue.splice(index, 1);
      this.setState({value: newValue})
    }
  }
  genOnChangeHandler(index, field_name, funcToGetValue = ((e) => e.target.value)) {
    return (e) => {
      this.changeValue(index, field_name, funcToGetValue(e));
    };
  }
  genOnOptionChangeHandler(index, option_index) {
    return (e) => {
      let newValue = this.state.value.slice();
      newValue[index].collection[option_index] = e.target.value;
      this.setState({value: newValue})
    };
  }
  genAddOptionHandler(index) {
    return (e) => {
      let newValue = this.state.value.slice();
      if(!newValue[index].collection)
        newValue[index].collection = [];
      newValue[index].collection.push('');
      this.setState({value: newValue})
    };
  }
  genRmOptionHandler(index, option_index) {
    return (e) => {
      let newValue = this.state.value.slice();
      newValue[index].collection.splice(option_index, 1);
      this.setState({value: newValue})
    };
  }
  changeValue(index, field_name, value) {
    let newValue = this.state.value.slice();
    newValue[index][field_name] = value;
    this.setState({value: newValue})
  }
  newFieldName(as) {
    return `${as}_${++this.available_fields_as_cnt[as]}`
  }
}
