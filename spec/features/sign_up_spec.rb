require 'rails_helper'

feature 'User can sign up', %q{
  In order to ask questions
  As an unregistered user
  I'd like to be able to sign up
} do

  background do
    visit root_path
    click_on 'Join'
  end

  scenario 'Unregistered user tries to sign_up' do
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'Unregistered user tries to sign_up with errors' do
    click_on 'Sign up'
    expect(page).to_not have_content 'Welcome! You have signed up successfully.'
  end
end
