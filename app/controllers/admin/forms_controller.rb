class Admin::FormsController < AdminController
  protected

  def current_model
    Admin::Form
  end

  def allowed_params
	  params.require(:admin_form).permit(:title, :fields)
  end
end
