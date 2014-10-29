class InterviewQuestionsController < ApplicationController
  def index
    @interview_questions = InterviewQuestion.order(:sort_id)
  end
end
