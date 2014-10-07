require_relative 'feature_helper'

feature 'User adds files to question and answer', %q{
  In order to illustrate my question
  As an author
  I want to be able to attach files to it
} do

  given(:user) {create(:user)}

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when asking question' do
    fill_in 'Title', with: 'title text'
    fill_in 'Text', with: 'body text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to have_content 'spec_helper.rb'
  end
end
