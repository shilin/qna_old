require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do

  describe 'POST #create' do

    let(:question) { create :question }

    context 'with valid attributes' do
      it 'saves a new answer to the database' do
        expect { post :create, question_id: question.id, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end

    #  it 'stays on question page' do
    #    post :create, answer: attributes_for(:answer), question_id: question 
    #    expect(response).to eq question_path(question)
    #  end
    end

    context 'with invalid attributes' do
      it 'fails to save an answer' do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question }.to_not change(Answer, :count)
      end
    #  it 'redirects to question show view' do
    #    post :create, answer:  attributes_for(:invalid_answer), question_id: question
    #    expect(response).to redirect_to question_path(question)
    #  end
    end

  end

end
