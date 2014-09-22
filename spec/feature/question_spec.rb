require 'rails_helper'

feature 'User can ask a question', %q{
In order to get the answers
As a user
I want to be able to ask questions
} do
  scenario 'User tries to submit a valid question' do
    visit new_question_path
    fill_in 'Title', with: 'Sample Title'
    fill_in 'Text', with: 'Sample Body'
    click_on 'Create'
    expect(page).to have_content 'Вопрос успешно задан'
  end

  scenario 'User tries to submit a invalid question' do
    visit new_question_path
    fill_in 'Title', with: 'Sample Title'
    #fill_in 'Text', with: 'Sample Body'
    click_on 'Create'

    expect(current_path).to eq new_question_path

  end
end
