require 'rails_helper'

feature 'User can delete the answer', %q{
  In case of need
  As an author of the answer
  I'd like to be able to delete it
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

  scenario 'An author of the answer tries to delete it' do
    sign_in(user)

    visit question_path(question)
    click_on 'Delete answer'
    expect(page).to have_content 'Answer deleted.'
    expect(page).to_not have_content answer.body
  end

  scenario 'User which is not an author of the answer tries to delete it' do
    non_author = create(:user)
    sign_in(non_author)

    visit question_path(question)
    expect(page).to_not have_content 'Delete answer'
  end

  scenario 'Unauthenticated user tries to delete an answer' do
    visit question_path(question)
    expect(page).to_not have_content 'Delete answer'
  end
end
