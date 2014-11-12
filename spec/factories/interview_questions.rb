# == Schema Information
#
# Table name: interview_questions
#
#  id         :integer          not null, primary key
#  question   :text             not null
#  answer     :text             not null
#  sort_id    :integer          default(0), not null
#  is_online  :boolean          default(FALSE), not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :interview_question do
    question do
      <<-EOS
#{Faker::Lorem.paragraph}

```ruby
class Post < ActiveRecord::Base
  has_many :comments
  def summary
    content.slice[0,150]
  end
end
```
EOS
    end
    answer do
      <<-EOS
#{Faker::Lorem.paragraph}

```ruby
class Post < ActiveRecord::Base
  has_many :comments
  def summary
    content.slice[0,150]
  end
end
```
EOS
    end
    is_online { rand > 0.5 }
  end
end
