require_relative 'feature_helper'

feature 'Answer editing', %q{
  In order to fix answer
  As an answer author
  I am able to edit answer

} do

  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question)}

  scenario 'Unauthenticated user tries to edit answer' do
    visit question_path(question)
    within '.answers' do
      expect(page).not_to have_link 'Edit'
    end
  end

  describe 'Authenticated user' do

    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'sees link Edit' do

      within '.answers' do
        expect(page).to have_link 'Edit'
      end

    end

    scenario 'tries to edit his own answer', js: true do
      click_on 'Edit'
      within '.answers' do
        fill_in 'Answer', with: 'edited answer'
      click_on 'Save'
      expect(page).to_not have_content answer.body
      expect(page).to have_content 'edited answer'
      expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'Tries to edit other user answer'

  end
end

