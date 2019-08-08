require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }

  describe 'GET #show' do
    it 'assigns the requested question to @question' do
      get :show, params: { id: answer }
      expect(assigns(:answer)).to eq(answer)
    end

    it 'renders show view' do
      get :show, params: { id: answer }
      expect(response).to render_template :show
    end
  end
end
