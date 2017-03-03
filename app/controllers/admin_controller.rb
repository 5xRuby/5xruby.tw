class AdminController < ApplicationController
  http_basic_authenticate_with Settings.http_basic_auth.to_h if Rails.env.production?
  def space_price
    @rental_request = Rental::Request.new
    @rental_request.days = [Rental::Day.new, Rental::Day.new]
  end

  helper_method :current_model, :current_object, :current_collection

  def new
    @current_object = current_model.new
  end

  def create
    @current_object = current_model.new(allowed_params)
    respond_to do |format|
      if current_object.save
        format.html { redirect_to current_object, notice: t('crud.created_successfully!', name: current_model.model_name.human) }
        format.json { render :show, status: :created, location: current_object }
      else
        format.html { render :new }
        format.json { render json: current_object.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if current_object.update(allowed_params)
        format.html { redirect_to (params[:ref] || current_object), notice: t('crud.updated_successfully!', name: current_model.model_name.human) }
        format.json { render :show, status: :ok, location: current_object }
      else
        format.html { render :edit }
        format.json { render json: current_object.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_object.destroy
    respond_to do |format|
      format.html { redirect_to action: :index, notice: t('crud.destroy_successfully!', name: current_model.model_name.human) }
      format.json { head :no_content }
    end
  end

  protected
  
  NOT_OVERWRITTEN_ERROR = "Must overwrite methods `current_model` and `allowed_params`"
  def current_model
    raise NOT_OVERWRITTEN_ERROR
  end
  def allowed_params
    raise NOT_OVERWRITTEN_ERROR
  end

  private

  def current_collection
    @current_collection ||= current_model.page(params[:page])
  end

  def current_object
    @current_object ||= current_model.find_by(id: params[:id])
  end
end
