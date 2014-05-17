require 'spec_helper'

describe "admin/faqs/edit" do
  before(:each) do
    @admin_faq = assign(:admin_faq, stub_model(Admin::Faq,
      :question => "MyText",
      :answer => "MyText",
      :is_online => false
    ))
  end

  it "renders the edit admin_faq form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_faq_path(@admin_faq), "post" do
      assert_select "textarea#admin_faq_question[name=?]", "admin_faq[question]"
      assert_select "textarea#admin_faq_answer[name=?]", "admin_faq[answer]"
      assert_select "input#admin_faq_is_online[name=?]", "admin_faq[is_online]"
    end
  end
end
