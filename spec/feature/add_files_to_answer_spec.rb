require_relative 'feature_helper.rb'

feature 'Add files to answer', %q{
  In order to illustrate answer
  As an answer author
  I want to be able to attach files
} do

  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given(:question) { create(:question, user: author) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Adds file when answering question', js: true do
    fill_in 'Your answer', with: 'My answer'
    attach_file "File", "#{Rails.root}/spec/spec_helper.rb"
    click_on "Create"
    within '.answers' do
      expect(page).to have_link 'spec_helper', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end

end
