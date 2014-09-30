require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do

  describe 'POST #create' do

    let(:question) { create :question }

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

end
