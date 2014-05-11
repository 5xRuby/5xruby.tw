require 'spec_helper'

describe "admin/applies/new" do
  before(:each) do
    assign(:admin_apply, stub_model(Admin::Apply,
      :course => nil,
      :stage => nil,
      :schedule => nil,
      :first_name => "MyString",
      :last_name => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :age => 1,
      :gender => "MyString",
      :message => "MyText"
    ).as_new_record)
  end

  it "renders new admin_apply form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_applies_path, "post" do
      assert_select "input#admin_apply_course[name=?]", "admin_apply[course]"
      assert_select "input#admin_apply_stage[name=?]", "admin_apply[stage]"
      assert_select "input#admin_apply_schedule[name=?]", "admin_apply[schedule]"
      assert_select "input#admin_apply_first_name[name=?]", "admin_apply[first_name]"
      assert_select "input#admin_apply_last_name[name=?]", "admin_apply[last_name]"
      assert_select "input#admin_apply_phone[name=?]", "admin_apply[phone]"
      assert_select "input#admin_apply_email[name=?]", "admin_apply[email]"
      assert_select "input#admin_apply_age[name=?]", "admin_apply[age]"
      assert_select "input#admin_apply_gender[name=?]", "admin_apply[gender]"
      assert_select "textarea#admin_apply_message[name=?]", "admin_apply[message]"
    end
  end
end
