require 'rails_helper'

feature 'User is able to browse a list of answers on the question page', %q{
  In order to know if my question was already answered
  As a user or a guest
  I'd like to be able to view the list of answers on the question page
} do

  given!(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 3, question_id: question.id) }

  scenario 'User tries to browse the question page' do
    visit question_path(question)
    answers.each { |answer| expect(page).to have_content answer.body }
  end
end
