require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  describe 'GET #index' do

    before do
      @questions = create_list(:question, 2)
      get :index
    end

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array @questions
    end

    it 'renders an index view' do
      expect(response).to render_template :index
    end

  end

  describe 'GET #new' do
    before { get :new }

    it 'creates a new question and assigns it to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders a new view' do
      expect(response).to render_template :new
    end

  end


  describe 'POST #create' do

    context 'with valid attributes' do

      it 'creates a new question and saves it into database' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirects a show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end

    end

    context 'with invalid attributes' do
      it 'creates a new question and fails to save it into database' do
        expect { post :create, question: {title: 'title' }}.to_not change(Question, :count)
      end


      it 'redirects back to a new view' do
        post :create, question: {title:  'title'}
        expect(response).to redirect_to new_question_path
      end

    end
  end

end
