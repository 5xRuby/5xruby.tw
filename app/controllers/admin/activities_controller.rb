class Admin::ActivitiesController < AdminController
  before_action :current_object, only: [:show, :edit]

  def index
    @current_collection = if params[:type] == "camp"
                            current_collection.where(type: "Activity::Camp")
                          else
                            current_collection.where(type: "Activity::Talk")
                          end
    @current_collection.order(id: :desc)
  end

  def show
  end

  def new
    source_activity = Admin::Activity.find_by(permalink: params[:permalink])
    @current_object = if source_activity
                        source_activity.fork
                      else
                        current_model.new
                      end
  end

  def edit
  end

  private

  def current_model
    Admin::Activity
  end

  def allowed_params
    params.require(:admin_activity).permit(:title, :permalink, :note, :payment_note, :is_online)
  end
end
