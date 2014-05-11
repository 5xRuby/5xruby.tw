class Admin::AppliesController < AdminController
  before_action :set_admin_apply, only: [:show, :edit, :update, :destroy]

  # GET /admin/applies
  # GET /admin/applies.json
  def index
    @admin_applies = Admin::Apply.all.order('id DESC').page(params[:page])
  end

  # GET /admin/applies/1
  # GET /admin/applies/1.json
  def show
  end

  # GET /admin/applies/new
  def new
    @admin_apply = Admin::Apply.new
  end

  # GET /admin/applies/1/edit
  def edit
  end

  # POST /admin/applies
  # POST /admin/applies.json
  def create
    @admin_apply = Admin::Apply.new(admin_apply_params)

    respond_to do |format|
      if @admin_apply.save
        format.html { redirect_to @admin_apply, notice: t('crud.created_successfully!', name: Admin::Apply.model_name.human) }
        format.json { render :show, status: :created, location: @admin_apply }
      else
        format.html { render :new }
        format.json { render json: @admin_apply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/applies/1
  # PATCH/PUT /admin/applies/1.json
  def update
    respond_to do |format|
      if @admin_apply.update(admin_apply_params)
        format.html { redirect_to @admin_apply, notice: t('crud.updated_successfully!', name: Admin::Apply.model_name.human) }
        format.json { render :show, status: :ok, location: @admin_apply }
      else
        format.html { render :edit }
        format.json { render json: @admin_apply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/applies/1
  # DELETE /admin/applies/1.json
  def destroy
    @admin_apply.destroy
    respond_to do |format|
      format.html { redirect_to admin_applies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_apply
      @admin_apply = Admin::Apply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_apply_params
      params.require(:admin_apply).permit(:course_id, :stage_id, :schedule_id, :first_name, :last_name, :phone, :email, :age, :gender, :message)
    end
end
