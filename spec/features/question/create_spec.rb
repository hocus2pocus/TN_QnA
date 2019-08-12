require 'rails_helper'

feature 'User can create question', %q{
  In order to get answer from community
  As an authenticated user
  I'd like to be able to ask the question
} do
  scenario 'Authenticated user asks a question' do
  end

  scenario 'Authenticated user asks a question with errors'
  scenario 'Unauthenticated user tries to ask a question'
end
