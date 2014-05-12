# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_speaker, :class => 'Admin::Speaker' do
    avatar "MyString"
    name "MyString"
    summary "MyText"
    is_online false
  end
end
