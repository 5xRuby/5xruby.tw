class Admin::SurveysController < AdminController
  protected

  def current_model
    Admin::Survey
  end

  def allowed_params
	  params.require(:admin_survey).permit(:title).tap do |whitelist|
	    whitelist[:questions] = JSON.parse(params[:admin_survey][:questions])
	  end
  end
end
