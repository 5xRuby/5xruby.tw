class Course < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros
  mount_uploader :image, CourseImageUploader

  # association macros
  has_many :stages, -> { order('sort_id') }, dependent: :destroy
  accepts_nested_attributes_for :stages, allow_destroy: true, reject_if: proc { |attributes| attributes[:title].blank? }

  # validation macros
  validates :title, presence: true

  # callbacks

  # other

  protected
  # callback methods
end
