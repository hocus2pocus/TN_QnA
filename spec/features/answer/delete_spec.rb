require 'rails_helper'

feature 'User can delete the answer', %q{
  In case of need
  As an author of the answer
  I'd like to be able to delete it
} do

  given(:author) { create(:user) }
  given(:question) { create(:question, author_id: author.id) }
  given!(:answer) { create(:answer, question_id: question.id, author_id: author.id) }

  scenario 'An author of the answer tries to delete it' do
    sign_in(author)

    visit question_path(question)
    click_on 'Delete answer'
    expect(page).to have_content 'Answer deleted.'
    expect(page).to_not have_content answer.body
  end

  scenario 'User which is not an author of the answer tries to delete it' do
    user = create(:user)
    sign_in(user)

    visit question_path(question)
    click_on 'Delete answer'
    expect(page).to have_content "You can't delete someone else's answer."
    expect(page).to have_content answer.body
  end
end
