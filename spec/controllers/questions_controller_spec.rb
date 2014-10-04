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

    context 'Authenticated user' do
    sign_in_user
      before { get :new }

      it 'creates a new question and assigns it to @question' do
        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'renders a new view' do
        expect(response).to render_template :new
      end

    end

    context 'Unauthenticated user' do
      it 'redirects to sign_in' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
  end


  describe 'POST #create' do

    context 'Authenticated user' do
      sign_in_user
      context 'with valid attributes' do

        it 'creates a new question and saves it into database' do
          expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
        end

        it 'creates a new question assigned to user' do
          post :create, question: attributes_for(:question) 
          expect(assigns(:question).user).to eq @user
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


    context 'Unauthenticated user' do
      it 'tries to post a new question and fails to save it into database' do
        expect { post :create, question: attributes_for(:question) }.to_not change(Question, :count)
      end

      it 'redirects to sign_in' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

  end

  describe "GET #edit" do

    context 'authenticated user' do
      sign_in_user

      it 'assigns the requested question to @question' do
        get :edit, id: question
        expect(assigns(:question)).to eq question
      end

      it 'renders edit view' do
        get :edit, id: question
        expect(response).to render_template :edit
      end
    end

    context 'unauthenticated user' do

      it 'redirects to sign_in' do
        get :edit, id: question
        expect(response).to redirect_to new_user_session_path
      end


    end

  end

  describe 'PATCH #update' do

    context 'Authenticated user' do

      sign_in_user

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

    context 'Unauthenticated user' do

      it 'fails to change question attributes' do
        patch :update, id: question, question: {title: 'newtitle', body: 'newbody'}
        question.reload
        expect(assigns(:question)).to_not eq question
      end

      it 'redirects to sign_in' do
        patch :update, id: question, question: { title: 'newtitle', body: 'newbody' }
        expect(response).to redirect_to new_user_session_path
      end

    end
  end

  describe 'DELETE #destroy' do

    describe 'Authenticated user' do
      sign_in_user

      it 'deletes the question' do
        question
        expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end

      it 'redirects to index view' do
        delete :destroy, id: question 
        expect(response).to redirect_to questions_path
      end
    end

    describe 'Unauthenticated user' do

      it 'fails to delete the question' do
        question
        expect { delete :destroy, id: question }.to_not change(Question, :count)
      end

      it 'redirects to sign_in' do
        delete :destroy, id: question
        expect(response).to redirect_to new_user_session_path
      end


    end


  end

end
