class Admin::SchedulesController < AdminController
  before_action :set_admin_schedule, only: [:show, :edit, :update, :destroy]

  # GET /admin/schedules
  # GET /admin/schedules.json
  def index
    @admin_schedules = Admin::Schedule.includes(:applies, stage: :course).order('id DESC').page(params[:page])
  end

  # GET /admin/schedules/1
  # GET /admin/schedules/1.json
  def show
  end

  # GET /admin/schedules/new
  def new
    @admin_schedule = Admin::Schedule.new
    @admin_schedule.events.new if @admin_schedule.events.empty?
  end

  # GET /admin/schedules/1/edit
  def edit
    @admin_schedule.events.new if @admin_schedule.events.empty?
  end

  # POST /admin/schedules
  # POST /admin/schedules.json
  def create
    @admin_schedule = Admin::Schedule.new(admin_schedule_params)

    respond_to do |format|
      if @admin_schedule.save
        format.html { redirect_to @admin_schedule, notice: t('crud.created_successfully!', name: Admin::Schedule.model_name.human) }
        format.json { render :show, status: :created, location: @admin_schedule }
      else
        format.html { render :new }
        format.json { render json: @admin_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/schedules/1
  # PATCH/PUT /admin/schedules/1.json
  def update
    respond_to do |format|
      if @admin_schedule.update(admin_schedule_params)
        format.html { redirect_to @admin_schedule, notice: t('crud.updated_successfully!', name: Admin::Schedule.model_name.human) }
        format.json { render :show, status: :ok, location: @admin_schedule }
      else
        format.html { render :edit }
        format.json { render json: @admin_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/schedules/1
  # DELETE /admin/schedules/1.json
  def destroy
    @admin_schedule.destroy
    respond_to do |format|
      format.html { redirect_to admin_schedules_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_schedule
      @admin_schedule = Admin::Schedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_schedule_params
      params.require(:admin_schedule).permit(
        :stage_id, :date, :description,
        events_attributes: %i[id _destroy title description speaker_id start_at]
      )
    end
end
