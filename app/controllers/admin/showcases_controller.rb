class Admin::ShowcasesController < AdminController
  include Sortable
  before_action :set_admin_showcase, only: [:show, :edit, :update, :destroy]

  # GET /admin/showcases
  # GET /admin/showcases.json
  def index
    @admin_showcases = Admin::Showcase.order(:sort_id)
  end

  # GET /admin/showcases/1
  # GET /admin/showcases/1.json
  def show
  end

  # GET /admin/showcases/new
  def new
    @admin_showcase = Admin::Showcase.new
  end

  # GET /admin/showcases/1/edit
  def edit
  end

  # POST /admin/showcases
  # POST /admin/showcases.json
  def create
    @admin_showcase = Admin::Showcase.new(admin_showcase_params)

    respond_to do |format|
      if @admin_showcase.save
        format.html { redirect_to @admin_showcase, notice: t('crud.created_successfully!', name: Admin::Showcase.model_name.human) }
        format.json { render :show, status: :created, location: @admin_showcase }
      else
        format.html { render :new }
        format.json { render json: @admin_showcase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/showcases/1
  # PATCH/PUT /admin/showcases/1.json
  def update
    respond_to do |format|
      if @admin_showcase.update(admin_showcase_params)
        format.html { redirect_to @admin_showcase, notice: t('crud.updated_successfully!', name: Admin::Showcase.model_name.human) }
        format.json { render :show, status: :ok, location: @admin_showcase }
      else
        format.html { render :edit }
        format.json { render json: @admin_showcase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/showcases/1
  # DELETE /admin/showcases/1.json
  def destroy
    @admin_showcase.destroy
    respond_to do |format|
      format.html { redirect_to admin_showcases_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_showcase
      @admin_showcase = Admin::Showcase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_showcase_params
      params.require(:admin_showcase).permit(:name, :description, :link, :image, :remove_image, :image_cache, :is_online, :sort_id)
    end
end
