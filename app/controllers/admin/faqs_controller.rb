class Admin::FaqsController < AdminController
  include Sortable
  before_action :set_admin_faq, only: [:show, :edit, :update, :destroy]

  # GET /admin/faqs
  # GET /admin/faqs.json
  def index
    @admin_faqs = Admin::Faq.order(:sort_id)
  end

  # GET /admin/faqs/1
  # GET /admin/faqs/1.json
  def show
  end

  # GET /admin/faqs/new
  def new
    @admin_faq = Admin::Faq.new
  end

  # GET /admin/faqs/1/edit
  def edit
  end

  # POST /admin/faqs
  # POST /admin/faqs.json
  def create
    @admin_faq = Admin::Faq.new(admin_faq_params)

    respond_to do |format|
      if @admin_faq.save
        format.html { redirect_to @admin_faq, notice: t('crud.created_successfully!', name: Admin::Faq.model_name.human) }
        format.json { render :show, status: :created, location: @admin_faq }
      else
        format.html { render :new }
        format.json { render json: @admin_faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/faqs/1
  # PATCH/PUT /admin/faqs/1.json
  def update
    respond_to do |format|
      if @admin_faq.update(admin_faq_params)
        format.html { redirect_to @admin_faq, notice: t('crud.updated_successfully!', name: Admin::Faq.model_name.human) }
        format.json { render :show, status: :ok, location: @admin_faq }
      else
        format.html { render :edit }
        format.json { render json: @admin_faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/faqs/1
  # DELETE /admin/faqs/1.json
  def destroy
    @admin_faq.destroy
    respond_to do |format|
      format.html { redirect_to admin_faqs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_faq
      @admin_faq = Admin::Faq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_faq_params
      params.require(:admin_faq).permit(:question, :answer, :is_online)
    end
end
