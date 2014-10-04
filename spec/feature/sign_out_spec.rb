require_relative 'feature_helper'

feature 'User can sign out', %q{
  In order to end the session
  As an authenticated user
  I want to be able to sign out
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user tries to sign out' do
    sign_in(user)
    visit root_path
    click_on 'Logout'
    expect(page).to have_content 'Signed out successfully'
  end
end
