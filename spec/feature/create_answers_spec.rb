require_relative 'feature_helper'

feature 'User answers question', %q{
In order to share my knowledge
As an authenticated user
I want to be able to create answers
} do

  given(:user) {create(:user)}
  given(:question) {create(:question)}
  scenario 'Authenticated user creates an answer', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in  'Your answer', with: 'MyAnswer'
    click_on 'Create'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'MyAnswer'
    end
  end

  
end
