# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_schedule, :class => 'Admin::Schedule' do
    stage nil
    date "2014-05-11"
    description "MyText"
  end
end
