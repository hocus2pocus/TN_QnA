require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'populates an array of all questions' do
      # question1 = FactoryBot.create(:question)
      # question2 = FactoryBot.create(:question)
      # questions = create_list(:question, 3)

      # get :index

      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      # get :index

      expect(response).to render_template :index
    end
  end
end
