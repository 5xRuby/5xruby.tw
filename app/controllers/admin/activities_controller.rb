class Admin::ActivitiesController < AdminController
  before_action :current_object, only: [:show, :edit]
  before_action :set_type, only: [:index]

  def index
    @current_collection = if params[:type] == "camp"
                            current_collection.where(type: "Activity::Camp")
                          else
                            current_collection.where(type: "Activity::Talk")
                          end
    @current_collection = @current_collection.order(id: :desc)
  end

  def show
    @admin_courses = current_object.courses.includes(:stages)
  end

  def new
    source_activity = current_model.find_by(permalink: params[:permalink])
    @current_object = source_activity ? source_activity.fork : current_model.new
  end

  def edit
  end

  def preview
    if (activity = current_model.find_by(permalink: params[:activity_id])&.specialized) && activity.template
      @camp = activity
      @activity_courses = @camp.activity_courses.includes(:course, { course: [:translations, { speakers: [:translations] }, { stages: [:translations] }] })
      @order = @camp.orders.new
      @speakers = @camp.speakers
      render 'camps/show', layout: 'application'
    else
      @talk = activity
      render 'talks/show', layout: 'application'
    end
  end


  private

  def current_model
    Admin::Activity
  end

  def allowed_params
    params.require(:admin_activity).permit(
      :type, :title, :permalink, :note,
      :payment_note, :is_online, :template_id, :survey_id,
      activity_courses_attributes: [:id, :subtitle, :course_id, :price, :priority, :_destroy]).tap do |whitelist|
        whitelist[:rules] = JSON.parse(params[:admin_activity][:rules])
      end
  end

  def set_type
    return unless query = URI(request.referer || "").query
    incoming_params = Hash[query.split("&").map{|p| p.split("=")}].symbolize_keys!
    params[:type] ||= incoming_params[:type]
  end

  def current_object
    @current_object ||= current_model.find_by(permalink: params[:id])
  end
end
