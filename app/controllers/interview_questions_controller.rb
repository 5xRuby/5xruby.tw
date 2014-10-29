class InterviewQuestionsController < ApplicationController
  def index
    @interview_questions = InterviewQuestion.all
  end
end
