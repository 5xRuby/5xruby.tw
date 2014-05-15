class Admin::SpeakersController < AdminController
  before_action :set_admin_speaker, only: [:show, :edit, :update, :destroy]

  # GET /admin/speakers
  # GET /admin/speakers.json
  def index
    @admin_speakers = Admin::Speaker.all.order('id DESC').page(params[:page])
  end

  # GET /admin/speakers/1
  # GET /admin/speakers/1.json
  def show
  end

  # GET /admin/speakers/new
  def new
    @admin_speaker = Admin::Speaker.new
  end

  # GET /admin/speakers/1/edit
  def edit
  end

  # POST /admin/speakers
  # POST /admin/speakers.json
  def create
    @admin_speaker = Admin::Speaker.new(admin_speaker_params)

    respond_to do |format|
      if @admin_speaker.save
        format.html { redirect_to @admin_speaker, notice: t('crud.created_successfully!', name: Admin::Speaker.model_name.human) }
        format.json { render :show, status: :created, location: @admin_speaker }
      else
        format.html { render :new }
        format.json { render json: @admin_speaker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/speakers/1
  # PATCH/PUT /admin/speakers/1.json
  def update
    respond_to do |format|
      if @admin_speaker.update(admin_speaker_params)
        format.html { redirect_to @admin_speaker, notice: t('crud.updated_successfully!', name: Admin::Speaker.model_name.human) }
        format.json { render :show, status: :ok, location: @admin_speaker }
      else
        format.html { render :edit }
        format.json { render json: @admin_speaker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/speakers/1
  # DELETE /admin/speakers/1.json
  def destroy
    @admin_speaker.destroy
    respond_to do |format|
      format.html { redirect_to admin_speakers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_speaker
      @admin_speaker = Admin::Speaker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_speaker_params
      params.require(:admin_speaker).permit(:avatar, :remove_avatar, :name, :summary, :is_online, :role, :title, :facebook_url, :twitter_url, :google_url, :blog_url)
    end
end
