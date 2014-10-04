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
        click_on 'Delete'
        expect(page).to have_content 'Your question has been successfully deleted'
      end

    end
    context 'is not author' do

      let(:question) { create(:question) }

      scenario 'tries to delete the question' do
        visit question_path(question)
        expect(page).to_not have_link 'Delete'
      end

    end
  end
end

