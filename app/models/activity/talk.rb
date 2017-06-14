class Activity::Talk < Activity
  # scope macros
  scope :online, -> { where(is_online: true) }
  scope :coming,->(count)  { joins(courses: :stages).select("activities.*", "min(date) as min_date").group("activities.id").order("min_date").limit(count) }
  scope :available, -> { online.joins(courses: :stages).select("activities.*").where('stages.date >= ?', Time.now).group("activities.id") }
  scope :with_category, ->(category) do
    joins(:courses).where("courses.category_id" => category.id)
  end

  # Concerns macros

  # Constants
  DELEGATE_METHODS = %i(image_url hours outdated? about_to_begin? start_on end_on suitable_for what_will_learn iframe_html apply_link).freeze
  DELEGATE_RESOURCES = %i(category image speakers stages)

  # Attributes related macros
  delegate *DELEGATE_METHODS, to: :course
  delegate *DELEGATE_RESOURCES, to: :course

  def course
    courses.first
  end

  # association macros

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
