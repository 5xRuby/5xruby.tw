# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_faq, :class => 'Admin::Faq' do
    question "MyText"
    answer "MyText"
    is_online false
  end
end
