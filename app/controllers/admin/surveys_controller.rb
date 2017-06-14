class Admin::SurveysController < AdminController
  protected

  def current_model
    Admin::Survey
  end

  def allowed_params
	  params.require(:admin_survey).permit(:title, :questions)
  end
end
