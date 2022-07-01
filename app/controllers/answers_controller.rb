class AnswersController < ApplicationController
  before_action :find_question
  before_action :find_answer, only: [:edit, :update, :destroy]
  before_action :authenticate_user!,  except: [:index, :show]

  def create
    @answer = @question.answers.create(answer_params)
    flash[:notice] = 'Your answer was successfully created.'
    redirect_to question_path(@question)
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      flash[:notice] = 'Your answer was successfully updated.'
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    flash[:notice] = 'Your answer was successfully deleted.'
    redirect_to question_path(@question)
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
