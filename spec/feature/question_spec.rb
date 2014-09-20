require 'rails_helper'

feature 'User can ask a question', %q{
In order to get the answers
As a user
I want to be able to ask questions
} do
  scenario 'User tries to submit a question' do
    visit new_question_path
    fill_in 'Title', with: 'Sample Title'
    fill_in 'Body', with: 'Sample Body'
    click_on 'Submit'
    expect(page).to have_content 'вопрос успешно создан'
  end
end
