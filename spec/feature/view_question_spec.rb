require 'rails_helper'

feature 'User can view questions', %q{
In order to see if the question was answered
As a user
I want to be able view questions
} do
  scenario 'User opens questions page' do
    # Question.create!(title: 'QuestionTitle', body: 'QuestionBody')
    2.times {Question.create!(title: 'QuestionTitle', body: 'QuestionBody')}
    visit questions_path

    expect(page).to have_content 'QuestionTitle', count: 2
  end

end
