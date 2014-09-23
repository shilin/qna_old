require 'rails_helper'

feature 'User can view questions', %q{
In order to see if the question was answered
As a user
I want to be able view questions
} do
  scenario 'User opens questions page' do
    visit questions_path
    save_and_open_page

    expect(page).to have_content 'Список вопросов'
  end

end
