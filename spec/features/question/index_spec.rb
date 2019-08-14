require 'rails_helper'

feature 'User is able to browse a list of questions', %q{
  In order to know if my question was already answered
  As a user or a guest
  I'd like to be able to view the list of all the questions
} do
  scenario 'User tries to view the list of questions' do
    questions = create_list(:question, 3)
    visit questions_path
    questions.each { |question| expect(page).to have_content question.title } #cheated
  end
end
