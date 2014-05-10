class Stage < ActiveRecord::Base
  # scope macros

  # Concerns macros
  include Select2Concern

  # Constants
  
  # Attributes related macros

  # association macros
  belongs_to :course
  has_many :schedules, -> { order(:date) }

  # validation macros
  validates :title, presence: true
  select2_white_list :title

  # callbacks

  # other

  protected
  # callback methods
end
