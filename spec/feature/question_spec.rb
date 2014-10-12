require_relative 'feature_helper'

feature 'User can ask a question', %q{
In order to get the answers
As a user
I want to be able to ask questions
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: other_user) }

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit new_question_path
    end

    scenario 'tries to submit a valid question' do
      fill_in 'Title', with: question.title
      fill_in 'Text', with: question.body
      click_on 'Create'
      expect(page).to have_content 'Вопрос успешно задан'
    end

    scenario 'tries to submit a invalid question' do
      fill_in 'Title', with: question.title
      click_on 'Create'
      expect(current_path).to eq new_question_path
    end
  end

  describe 'Unauthenticated user' do

    scenario 'tries to submit a question' do
      visit new_question_path
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
  end
end
