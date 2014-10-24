class Admin::InterviewQuestionsController < AdminController
  include Sortable
  before_action :set_admin_interview_question, only: [:show, :edit, :update, :destroy]

  # GET /admin/interview_questions
  # GET /admin/interview_questions.json
  def index
    @admin_interview_questions = Admin::InterviewQuestion.order(:sort_id)
  end

  # GET /admin/interview_questions/1
  # GET /admin/interview_questions/1.json
  def show
  end

  # GET /admin/interview_questions/new
  def new
    @admin_interview_question = Admin::InterviewQuestion.new
  end

  # GET /admin/interview_questions/1/edit
  def edit
  end

  # POST /admin/interview_questions
  # POST /admin/interview_questions.json
  def create
    @admin_interview_question = Admin::InterviewQuestion.new(admin_interview_question_params)

    respond_to do |format|
      if @admin_interview_question.save
        format.html { redirect_to @admin_interview_question, notice: t('crud.created_successfully!', name: Admin::InterviewQuestion.model_name.human) }
        format.json { render :show, status: :created, location: @admin_interview_question }
      else
        format.html { render :new }
        format.json { render json: @admin_interview_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/interview_questions/1
  # PATCH/PUT /admin/interview_questions/1.json
  def update
    respond_to do |format|
      if @admin_interview_question.update(admin_interview_question_params)
        format.html { redirect_to (params[:ref] || @admin_interview_question), notice: t('crud.updated_successfully!', name: Admin::InterviewQuestion.model_name.human) }
        format.json { render :show, status: :ok, location: @admin_interview_question }
      else
        format.html { render :edit }
        format.json { render json: @admin_interview_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/interview_questions/1
  # DELETE /admin/interview_questions/1.json
  def destroy
    @admin_interview_question.destroy
    respond_to do |format|
      format.html { redirect_to admin_interview_questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_interview_question
      @admin_interview_question = Admin::InterviewQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_interview_question_params
      params.require(:admin_interview_question).permit(:question, :answer, :sort_id, :is_online)
    end
end
