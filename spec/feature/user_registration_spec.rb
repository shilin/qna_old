require_relative 'feature_helper'

feature 'User can register', %q{
  In order to be able to exchange knowledge
  As a user
  I want to be able to register
} do

  describe 'not registered user' do

    scenario 'tries to sign up' do
      visit new_user_registration_path
      fill_in  'Email', with: 'user@test.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'
      expect(page).to have_content 'You have signed up successfully'
    end

    scenario 'tries to sign up with password typo' do
      visit new_user_registration_path
      fill_in  'Email', with: 'user@test.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345679999999'
      click_on 'Sign up'
      expect(page).to have_content "Password confirmation doesn't match Password"

    end
  end

  describe 'Registered user' do
    let(:user) { create :user }

    scenario 'tries to sign up' do
      visit new_user_registration_path
      fill_in  'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password_confirmation
      click_on 'Sign up'
      expect(page).to have_content 'Email has already been taken'
    end
  end
end
