require 'rails_helper'

feature 'User can sign out', %q{
  In order to protect my account
  As an authenticated user
  I'd like to be able to sign out
} do

  scenario 'Authenticated user tries to sign out' do
    user = create(:user)
    sign_in(user)

    click_on 'Sign out'
    expect(page).to have_content 'Signed out successfully.'
  end
end
