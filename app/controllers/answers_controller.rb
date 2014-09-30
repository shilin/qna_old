class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @question.answers.create(answer_params)
      #render 'create.js.erb'
    
  end

  private
  
  def answer_params
    params.require(:answer).permit(:body)
  end
end
