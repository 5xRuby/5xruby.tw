class Admin::CoursesController < AdminController
  before_action :set_admin_course, only: [:edit, :update, :destroy]

  # GET /admin/courses
  # GET /admin/courses.json
  def index
    @admin_courses = Admin::Course.order('id DESC').includes(:category).page(params[:page])
  end

  # GET /admin/courses/1
  # GET /admin/courses/1.json
  def show
    @admin_course = Admin::Course.includes(:stages).find_by!(permalink: params[:id])
  end

  # GET /admin/courses/new
  def new
    @admin_course = if source_course = Admin::Course.find_by(permalink: params[:fork])
      source_course.fork
    else
      Admin::Course.new
    end
    @admin_course.stages.new if @admin_course.stages.empty?
  end

  # GET /admin/courses/1/edit
  def edit
    @admin_course.stages.new if @admin_course.stages.empty?
  end

  # POST /admin/courses
  # POST /admin/courses.json
  def create
    @admin_course = Admin::Course.new(admin_course_params)

    respond_to do |format|
      if @admin_course.save
        format.html { redirect_to @admin_course, notice: t('crud.created_successfully!', name: Admin::Course.model_name.human) }
        format.json { render :show, status: :created, location: @admin_course }
      else
        format.html { render :new }
        format.json { render json: @admin_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/courses/1
  # PATCH/PUT /admin/courses/1.json
  def update
    respond_to do |format|
      if @admin_course.update(admin_course_params)
        format.html { redirect_to @admin_course, notice: t('crud.updated_successfully!', name: Admin::Course.model_name.human) }
        format.json { render :show, status: :ok, location: @admin_course }
      else
        format.html { render :edit }
        format.json { render json: @admin_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/courses/1
  # DELETE /admin/courses/1.json
  def destroy
    @admin_course.destroy
    respond_to do |format|
      format.html { redirect_to admin_courses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_course
      @admin_course = Admin::Course.find_by!(permalink: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_course_params
      params.require(:admin_course).permit(
        :maximum_attendees, :maximum_attendees, :minimum_attendees, :iframe_html, :category_id, :image, :remove_image, :image_cache, :title, :permalink, :subtitle,
        :summary, :description, :what_will_learn, :is_online, :note, :apply_link,
        speaker_ids: [],
        stages_attributes: %i[id _destroy title description date start_at end_at]
      )
    end
end
