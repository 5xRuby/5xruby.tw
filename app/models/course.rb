# == Schema Information
#
# Table name: courses
#
#  id              :integer          not null, primary key
#  image           :string(255)
#  title           :string(255)      not null
#  summary         :text
#  description     :text
#  what_will_learn :text
#  created_at      :datetime
#  updated_at      :datetime
#  subtitle        :string(255)
#  category_id     :integer
#

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
  belongs_to :category

  # validation macros
  validates :title, presence: true
  select2_white_list :title

  # callbacks

  # other
  class << self
    def search params
      ret = self
      ret = ret.where(category_id: params[:category_id]) if Category.find_by(id: params[:category_id])
      ret
    end
  end

  protected
  # callback methods
end
