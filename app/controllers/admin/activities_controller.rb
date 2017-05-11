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
  end

  def new
    source_activity = Admin::Activity.find_by(permalink: params[:permalink])
    @current_object = source_activity ? source_activity.fork : current_model.new
  end

  def edit
  end

  private

  def current_model
    Admin::Activity
  end

  def allowed_params
    params.require(:admin_activity).permit(
      :type, :title, :permalink, :note,
      :payment_note, :is_online, :template_id,
      activity_courses_attributes: [:id, :course_id, :_destroy])
  end

  def set_type
    return unless query = URI(request.referer || "").query
    incoming_params = Hash[query.split("&").map{|p| p.split("=")}].symbolize_keys!
    params[:type] ||= incoming_params[:type]
  end
end
