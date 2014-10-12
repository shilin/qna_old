require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do


  context 'Authenticated user' do

    let(:author) { create(:user) }
    let!(:question) { create :question, user: author }
    sign_in_user

    describe 'POST #create' do

      context 'with valid attributes' do
        it 'saves a new answer to the database' do
          expect { post :create, question_id: question.id, answer: attributes_for(:answer), format: :js }.to change(question.answers, :count).by(1)
        end

        it 'renders create.js template' do
          post :create, answer: attributes_for(:answer), question_id: question, format: :js
          expect(response).to render_template  :create
        end
      end

      context 'with invalid attributes' do
        it 'fails to save an answer' do
          expect { post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js }.to_not change(Answer, :count)
        end
        it 'renders create.js template' do
          post :create, answer:  attributes_for(:invalid_answer), question_id: question, format: :js
          expect(response).to render_template :create
        end
      end

    end

    describe 'PATCH #update' do
      let(:answer) { create(:answer, question: question) }

      it 'assigns the requested answer to @answer' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:answer)).to eq answer
      end

      it 'assigns the question' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:question)).to eq question
      end

      it 'changes answer attributes' do
        patch :update, id: answer, question_id: question, answer: {body: 'new body' }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'renders update template' do
        patch :update, id: answer, question_id: question, answer: {body: 'new body' }, format: :js
        expect(response).to render_template :update

      end
    end
  end

  context 'Unauthenticated user' do

    let(:author) { create(:user) }
    let!(:question) { create :question, user: author }

    describe 'POST #create' do

      context 'with valid attributes' do
        it 'fails to save a new answer to the database' do
          expect { post :create, question_id: question.id, answer: attributes_for(:answer), format: :js }.to_not change(question.answers, :count)
        end
      end

    end

  end

end
