class QuestionsController < ApplicationController

  def new
    @question = Question.new
  end
  
  def create
    @question = Question.create(question_params)
    flash[:notice] = 'Вопрос успешно задан'
    redirect_to @question
  end
  
  def show

  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
