require_relative 'feature_helper'

feature 'Author can delete his question', %q{
  In order to remove bad question
  As an author
  I should be able to delete the question
} do


  describe 'Authenticated user' do
    given(:user) { create(:user) }

    before do
      sign_in(user)
    end

    context 'is author' do

      let(:question) { create(:question, user: user) }

      scenario 'tries to delete the question' do
        visit question_path(question)
        within('.question-delete') do
          click_on 'Delete'
        end
        expect(page).to have_content 'Your question has been successfully deleted'
      end

      scenario 'tries to edit his own answer', js: true do
        visit question_path(question)
        within('.question') do
          click_on 'Edit'
          fill_in 'Question', with: 'edited question'
          click_on 'Save'
          expect(page).to_not have_content question.body
          expect(page).to have_content 'edited question'
          expect(page).to_not have_selector 'textarea'
        end
      end

    end
    context 'is not author' do

      let(:question) { create(:question) }

      scenario 'fails to delete the question' do
        visit question_path(question)
        expect(page).to_not have_link 'Delete'
      end

      scenario 'fails to edit the question' do
        visit question_path(question)
        within('.question') do
          expect(page).to_not have_link 'Delete'
        end
      end

    end
  end
end

