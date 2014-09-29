require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  let(:question) { create(:question)}

  describe 'GET #index' do

      let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array questions
    end

    it 'renders an index view' do
      expect(response).to render_template :index
    end

  end


  describe 'GET #show' do
    before { get :show, id: question  }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    
    it 'assigns new answer to @question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end

  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }

    it 'creates a new question and assigns it to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders a new view' do
      expect(response).to render_template :new
    end

  end


  describe 'POST #create' do

    sign_in_user
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
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end


      it 'redirects back to a new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to redirect_to new_question_path
      end

    end
  end

  describe "GET #edit" do

    it 'assigns the requested question to @question' do
      get :edit, id: question
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      get :edit, id: question
      expect(response).to render_template :edit
    end

  end

  describe 'PATCH #update' do

    context 'with valid attributes' do
      it 'updates the requested question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end

      it 'changes attributes' do
        patch :update, id: question, question: {title: "UpdatedTitle", body: "UpdatedBody"}
        question.reload
        expect(question.title).to eq "UpdatedTitle"
        expect(question.body).to eq "UpdatedBody"
      end

      it 'redirects to updated question' do
        patch :update, id: question, question: {title: "UpdatedTitle", body: "UpdatedBody"}
        expect(response).to redirect_to question
      end

    end

    context 'with invalid attributes' do

      it 'fails to change attributes' do
        patch :update, id: question, question: attributes_for(:invalid_question)
        question.reload
        expect(question.title).to  eq "QuestionTitle"
        expect(question.body).to   eq "QuestionBody"
      end

      it 'redirects to edit view' do
        patch :update, id: question, question: attributes_for(:invalid_question)
        expect(response).to render_template :edit
      end

    end

  end

  describe 'DELETE #destroy' do
    it 'deletes the question' do
      question
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, id: question 
      expect(response).to redirect_to questions_path
    end


  end

end
