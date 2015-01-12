class InterviewQuestionsController < ApplicationController
  def index
    @interview_questions = InterviewQuestion.available.order(:sort_id)
  end
end
