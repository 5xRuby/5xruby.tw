class Stage < ActiveRecord::Base
  # scope macros

  # Concerns macros
  include Select2Concern

  # Constants

  # Attributes related macros

  # association macros
  belongs_to :course
  has_many :translations, as: :translatable

  # validation macros
  validates :title, :date, :start_at, :end_at, :hours, presence: true
  select2_white_list :title

  # callbacks
  after_initialize :set_defualt_values, if: :new_record?, unless: :changed?

  # other

  private
  def set_defualt_values
    self.date = Time.now.strftime('%Y-%m-%d')
    self.start_at = '09:30'
    self.end_at = '17:00'
  end
end
