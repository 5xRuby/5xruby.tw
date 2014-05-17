require 'spec_helper'

describe "admin/faqs/new" do
  before(:each) do
    assign(:admin_faq, stub_model(Admin::Faq,
      :question => "MyText",
      :answer => "MyText",
      :is_online => false
    ).as_new_record)
  end

  it "renders new admin_faq form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_faqs_path, "post" do
      assert_select "textarea#admin_faq_question[name=?]", "admin_faq[question]"
      assert_select "textarea#admin_faq_answer[name=?]", "admin_faq[answer]"
      assert_select "input#admin_faq_is_online[name=?]", "admin_faq[is_online]"
    end
  end
end
