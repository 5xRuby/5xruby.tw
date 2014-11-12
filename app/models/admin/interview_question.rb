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

class Admin::InterviewQuestion < InterviewQuestion
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
