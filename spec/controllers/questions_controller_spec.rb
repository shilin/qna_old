require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

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

  end

end
