require_relative 'feature_helper'

feature 'User answers question', %q{
In order to share my knowledge
As an authenticated user
I want to be able to create answers
} do

  given(:user) {create(:user)}
  given(:question) {create(:question)}

  describe 'Authenticated user' do

    before do
      sign_in(user)
    end

    scenario 'creates an answer', js: true do
      visit question_path(question)
      fill_in  'Your answer', with: 'MyAnswer'
      click_on 'Create'
      expect(current_path).to eq question_path(question)
      within '.answers' do
        expect(page).to have_content 'MyAnswer'
      end
    end

    scenario 'User tries to create invalid answer', js: true do
      visit question_path(question)
      click_on 'Create'
      expect(page).to have_content "Body can't be blank"
    end
  end

  describe 'Unauthenticated user' do

    scenario 'tries to create an answer'

  end

end
