require 'rails_helper'

RSpec.describe "Answers", type: :request do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question_id: question.id) }
  let(:another_q_answers) { create_list(:answer, 2) }

  describe 'GET /show' do
    before { get answer_url(answer, question_id: question.id) }

    it 'assigns the requested answer to @answer of the right question' do
      expect(assigns(:answer)).to eq(answer)
      expect(answer.question_id).to eq(question.id)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET /new' do
    before { get new_answer_url(question_id: question.id) }

    it 'assigns a new answer to @answer of @question' do
      expect(assigns(:answer)).to be_a_new(Answer)
      expect(answer.question_id).to eq(question.id)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'saves the new answer in the database for the right question' do
        expect { post answers_url(question_id: question.id), params: { answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to new view' do
        post answers_url(question_id: question.id), params: { answer: attributes_for(:answer) }
        expect(response).to redirect_to answer_path(assigns(:answer))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post answers_url(question_id: question.id), params: { answer: attributes_for(:invalid_answer) } }.to_not change(question.answers, :count)
      end

      it 're-renders new view' do
        post answers_url(question_id: question.id), params: { answer: attributes_for(:invalid_answer) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET /edit' do
    before { get edit_answer_url(answer, question_id: question.id) }

    it 'assigns the requested answer to @answer of @question' do
      expect(assigns(:answer)).to eq(question.answers.find(answer.id))
    end

    it 'renders new view' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH /update' do
    context 'with valid attributes' do
      it 'assigns the requested answer to @answer of @question' do
        patch answer_url(answer, question_id: question.id), params: { answer: attributes_for(:answer) }
        expect(assigns(:answer)).to eq(question.answers.find(answer.id))
      end

      it 'changes answer attributes of the right question' do
        patch answer_url(answer, question_id: question.id), params: { answer: { body: 'answer modified' } }
        answer.reload
        expect(answer.body).to eq('answer modified')
      end

      it 'redirects to the updated answer' do
        patch answer_url(answer, question_id: question.id), params: { answer: attributes_for(:answer) }
        expect(response).to redirect_to(answer)
      end
    end

    context 'with invalid attributes' do
      before { patch answer_url(answer, question_id: question.id), params: { answer: { body: nil } } }

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
    before { answer }

    it 'deletes answer' do
      expect { delete answer_url(answer, question_id: question.id) }.to change(question.answers, :count).by(-1)
    end

    it 'redirect to question show view' do
      delete answer_url(answer, question_id: question.id)
      expect(response).to redirect_to(question)
    end
  end
end
