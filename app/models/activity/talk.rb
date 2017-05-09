class Activity::Talk < Activity
  # scope macros
  scope :online, -> { where(is_online: true) }
  scope :coming, -> { joins(courses: :stages).select("activities.*, min(date) as min_date").group(:id).order("min_date") }
  scope :available, -> { online.joins(courses: :stages).where('stages.date >= ?', Time.now).distinct }
  scope :with_category, ->(category) do
    joins(:courses).where("courses.category_id" => category.id)
  end

  # Concerns macros

  # Constants
  DELEGATE_METHODS = %i(image image_url category hours outdated? speakers suitable_for what_will_learn stages iframe_html apply_link).freeze

  # Attributes related macros
  delegate *DELEGATE_METHODS, to: :course

  # association macros

  # validation macros

  # callbacks

  # other
  def course
    courses.first
  end

  protected
  # callback methods
end
