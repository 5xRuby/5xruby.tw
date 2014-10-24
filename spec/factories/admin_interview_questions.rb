# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_interview_question, :class => 'Admin::InterviewQuestion' do
    question "MyText"
    answer "MyText"
    sort_id 1
    is_online false
  end
end
