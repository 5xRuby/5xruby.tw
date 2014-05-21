# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_apply, :class => 'Admin::Apply' do
    course nil
    stage nil
    schedule nil
    first_name "MyString"
    last_name "MyString"
    phone "MyString"
    email "MyString"
    age 1
    gender %i[male female].sample
    message "MyText"
  end
end
