require 'spec_helper'

describe "admin/schedules/new" do
  before(:each) do
    assign(:admin_schedule, stub_model(Admin::Schedule,
      :stage => nil,
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new admin_schedule form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_schedules_path, "post" do
      assert_select "input#admin_schedule_stage[name=?]", "admin_schedule[stage]"
      assert_select "textarea#admin_schedule_description[name=?]", "admin_schedule[description]"
    end
  end
end
