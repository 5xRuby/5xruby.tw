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
#  is_online       :boolean          default(FALSE), not null
#  permalink       :string(255)      not null
#  note            :text
#  apply_link      :string(255)
#  iframe_html     :string(255)
#

class Course < ActiveRecord::Base
  # scope macros
  scope :online, -> { where(is_online: true) }

  # Concerns macros
  include Select2Concern
  include Permalinkable

  # Constants

  # Attributes related macros
  mount_uploader :image, CourseImageUploader
  permalinkable :title

  # association macros
  has_many :stages, -> { order(:date) }, dependent: :destroy
  accepts_nested_attributes_for :stages, allow_destroy: true, reject_if: proc { |attributes| attributes[:title].blank? }
  has_many :schedules, through: :stages
  has_many :applies
  has_and_belongs_to_many :speakers
  belongs_to :category, counter_cache: true

  # validation macros
  validates :title, presence: true
  validates :summary, length: {maximum: 150}
  select2_white_list :title

  # callbacks

  # other
  def fork
    the_forked = self.class.new attributes.except!('id', 'iframe', 'is_online')
    if number = the_forked.permalink[/(\d+)$/, 1]
      the_forked.permalink.sub!(/(\d+)$/, (number.to_i + 1).to_s)
    else
      the_forked.permalink += '-1'
    end
    the_forked.speakers = speakers
    the_forked.image = image
    stages.each do |stage|
      the_forked.stages << Stage.new(stage.attributes.except!('id'))
    end
    the_forked
  end

  def hours
    stages.to_a.sum(&:duration)
  end

  protected
  # callback methods
end
