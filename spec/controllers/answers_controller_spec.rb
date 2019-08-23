require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user_id: user.id)}

  describe 'POST #create' do
    context "For authenticated user" do
      before { login(user) }

      it "proves that new Answer is owned by @question" do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(assigns(:answer).question).to eq(question)
      end

      context 'with valid attributes' do
        it 'saves a new answer in the database' do
          expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(question.answers, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { answer: attributes_for(:answer), question_id: question }
          expect(response).to redirect_to assigns(:question)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question' do
          expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question } }.to_not change(question.answers, :count)
        end

        it 're-renders new view' do
          post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }
          expect(response).to render_template 'questions/show'
        end
      end
    end

    context "For unauthenticated user" do
      context 'with valid attributes' do
        it 'saves a new answer in the database' do
          expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to_not change(question.answers, :count)
        end

        it 'renders login form' do
          post :create, params: { answer: attributes_for(:answer), question_id: question }
          expect(response).to redirect_to '/users/sign_in'
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

    context "For authenticated author" do
      before { login(user) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to answer.question
      end
    end

    context "For authenticated non author" do
      let(:non_author) { create(:user) }
      before { login(non_author) }

      it 'does not deletes the answer' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end
    end

    context "For unauthenticated user" do
      it 'does not deletes the answer' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end

      it 'renders login form' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
