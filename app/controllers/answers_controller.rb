class AnswersController < ApplicationController
  before_action :find_question, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :find_answer, only: [:show, :edit, :update, :destroy]

  def show; end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @answer
    else
      render :new
    end
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to @question
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
