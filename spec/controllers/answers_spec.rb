require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question, body: 'MyText') }
  let(:another_q_answers) { create_list(:answer, 2) }

  describe 'POST /create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new answer in the database for the right question' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:invalid_answer) } }.to_not change(question.answers, :count)
      end

      it 'redirects to question show view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:invalid_answer) }
        expect(response).to redirect_to question_path(question)
      end
    end
  end

  describe 'GET /edit' do
    sign_in_user

    before { get :edit, params: { id: answer, question_id: question.id} }

    it 'assigns the requested answer to @answer of @question' do
      expect(assigns(:answer)).to eq(question.answers.find(answer.id))
    end

    it 'renders new view' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH /update' do
    sign_in_user

    context 'with valid attributes' do
      it 'assigns the requested answer to @answer of @question' do
        patch :update, params: { id: answer, question_id: question.id, answer: attributes_for(:answer) }
        expect(assigns(:answer)).to eq(question.answers.find(answer.id))
      end

      it 'changes answer attributes of the right question' do
        patch :update, params: { id: answer, question_id: question.id, answer: { body: 'answer modified' } }
        answer.reload
        expect(answer.body).to eq('answer modified')
      end

      it 'redirects to the updated answer' do
        patch :update, params: { id: answer, question_id: question.id, answer: attributes_for(:answer) }
        expect(response).to redirect_to(question)
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: answer, question_id: question.id, answer: { body: nil } } }

      it 'does not change answer attributes' do
        answer.reload
        expect(answer.body).to eq('MyText')
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE /destroy' do
    sign_in_user
    
    before { answer }

    it 'deletes answer' do
      expect { delete :destroy, params: { id: answer, question_id: question.id} }.to change(question.answers, :count).by(-1)
    end

    it 'redirect to question show view' do
      delete :destroy, params: { id: answer, question_id: question.id}
      expect(response).to redirect_to(question)
    end
  end
end
