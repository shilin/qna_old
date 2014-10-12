class AnswersController < ApplicationController

  before_action :authenticate_user!, except:  [:show, :index]
  before_action :load_question, only: [:create, :update]
  def create
    @answer = @question.answers.create(answer_params)
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
  end
  private
  
  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
end
