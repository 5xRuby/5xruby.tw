class Admin::IndexPicturesController < AdminController
  helper_method :current_model, :current_object, :current_collection

  def index
  end

  def show
  end

  def new
    @current_object = current_model.new
  end

  def edit
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
      format.html { redirect_to action: :index }
      format.json { head :no_content }
    end
  end

  private
    def current_model
      Admin::IndexPicture
    end

    def current_collection
      @current_collection ||= current_model.page(params[:page])
    end

    def current_object
      @current_object ||= current_model.find_by(id: params[:id])
    end

    def allowed_params
      params.require(:admin_index_picture).permit(:alt, :href, index_picture_imgs_attributes: %i[id _destroy src size lang])
    end
end
