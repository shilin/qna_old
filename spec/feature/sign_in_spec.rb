require 'rails_helper'

feature 'User sign in', %q{
In order to be able to ask questions
As a user
I want to be able to sign in
} do
  scenario 'Registered user tries to sign in' do
    login_user
    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Not registered user tries to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'
    expect(page).to have_content 'Invalid email address or password'
    expect(current_path).to eq new_user_session_path

  end
end
