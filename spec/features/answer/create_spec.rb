require 'rails_helper'

feature 'User can create answer for the question', %q{
  In order to help the community member
  As an authenticated user
  I'd like to be able to answer the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do

    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'answers the question' do
      fill_in 'Answer', with: 'My answer'
      click_on 'Submit'

      expect(page).to have_content 'Answer saved.'
      expect(page).to have_content 'My answer'
    end

    scenario 'answers the question with errors'
  end

  scenario 'Unauthenticated user tries to answer the question'
end
