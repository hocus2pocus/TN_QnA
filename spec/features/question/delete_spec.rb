require 'rails_helper'

feature 'User can delete the question', %q{
  In case of need
  As an author of the question
  I'd like to be able to delete it
} do

  given(:author) { create(:user) }
  given(:question) { create(:question, author_id: author.id) }

  scenario 'An author of the question tries to delete it' do
    sign_in(author)

    visit question_path(question)
    click_on 'Delete question'
    expect(page).to have_content 'Question deleted.'
    expect(page).to_not have_content question.title
  end

  scenario 'User which is not an author of the question tries to delete it' do
    user = create(:user)
    sign_in(user)

    visit question_path(question)
    click_on 'Delete question'
    expect(page).to have_content "You can't delete someone else's question."
    expect(page).to have_content question.title
  end
end
