require 'rails_helper'

feature 'User is able to browse a list of questions', %q{
  In order to know if my question was already asked
  As a user or a guest
  I'd like to be able to view the list of all the questions
} do

  given!(:questions) { create_list(:question, 3) }

  scenario 'User tries to view the list of questions' do
    visit questions_path
    questions.each { |question| expect(page).to have_content question.title }
  end
end
