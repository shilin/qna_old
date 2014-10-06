class QuestionsController < ApplicationController

  before_action :authenticate_user!, only: [:edit, :new, :update, :create, :destroy]
  before_action :load_question, only: [:show, :update, :edit, :destroy]

  def index
    @questions = Question.all
  end

  def edit
  end
    
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      flash[:notice] = 'Вопрос успешно задан'
      redirect_to @question
    else
      redirect_to new_question_path
    end

  end
  
  def show
    @answer = @question.answers.build
  end

  def update
    @question.update(question_params) if @question.user == current_user
  end

  def destroy
    if  @question.user == current_user
      flash[:notice] = 'Your question has been successfully deleted' if @question.destroy
    end
    redirect_to questions_path
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end
end
