class Admin::CampTemplatesController < AdminController
  def index
    @current_collection = current_collection.order(id: :desc)
  end

  def new
    @current_object = current_model.new(payload: CampTemplateLoader.new.to_h)
  end

  def show; end

  def edit; end

  protected

  def current_model
    Admin::CampTemplate
  end

  def current_object
    @current_object ||= current_model.find_by(id: params[:id] || params[:camp_template_id])
  end

  def allowed_params
    params.require(:admin_camp_template).permit(:title).tap do |whitelist|
      whitelist[:payload] = JSON.parse(params[:admin_camp_template][:payload])
    end
  end
end
