class Admin::CampTemplatesController < AdminController

  def new
    @current_object = current_model.new(payload: current_object.try(:payload))
  end

  def preview
    @camp = CampTemplateLoader.use CampTemplate.find(params[:camp_template_id])
    render 'pages/camp', layout: 'application'
  end

  def active
    current_object.active!
    respond_to do |format|
      format.html { redirect_to({action: :index}, notice: t('crud.updated_successfully!', name: current_model.model_name.human)) }
      format.json { render :show, status: :ok, location: current_object }
    end
  end

  protected

  def current_model
    Admin::CampTemplate
  end

  def current_object
    @current_object ||= current_model.find_by(id: params[:id] || params[:camp_template_id])
  end

  def allowed_params
    params.require(:admin_camp_template).permit(:json, :lang)
  end
end
