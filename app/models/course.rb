class Course < ActiveRecord::Base
  # scope macros

  # Concerns macros
  include Select2Concern

  # Constants
  
  # Attributes related macros
  mount_uploader :image, CourseImageUploader

  # association macros
  has_many :stages, -> { order('sort_id') }, dependent: :destroy
  accepts_nested_attributes_for :stages, allow_destroy: true, reject_if: proc { |attributes| attributes[:title].blank? }
  has_many :schedules, through: :stages
  has_many :applies

  # validation macros
  validates :title, presence: true
  select2_white_list :title

  # callbacks

  # other

  protected
  # callback methods
end
