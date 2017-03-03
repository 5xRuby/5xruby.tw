class Admin::CampSettingsController < AdminController

  def new
    @current_object = current_model.new(payload: current_object.try(:payload))
  end

  def preview
    @camp = Camp.use CampSetting.find(params[:camp_setting_id]) 
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
    Admin::CampSetting
  end

  def current_object
    @current_object ||= current_model.find_by(id: params[:id] || params[:camp_setting_id])
  end

  def allowed_params
    params.require(:admin_camp_setting).permit(:json, :lang)
  end
end
