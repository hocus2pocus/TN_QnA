require 'rails_helper'

feature 'User is able to browse a list of answers on the question page', %q{
  In order to know if my question was already answered
  As a user or a guest
  I'd like to be able to view the list of answers on the question page
} do
  scenario 'User tries to browse the question page' do
    question = create(:question)
    answers = create_list(:answer, 3, question_id: question.id)

    visit question_path(question)
    answers.each { |answer| expect(page).to have_content answer.body }
    answers.each { |answer| expect(answer.question_id).to eq question.id }
  end
end
