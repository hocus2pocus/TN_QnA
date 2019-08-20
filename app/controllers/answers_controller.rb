class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: %i[new create]
  before_action :load_answer, only: %i[show edit update destroy]

  # def index
  #   @answers = @question.answers.all
  # end

  # def show
  # end

  # def new
  #   @answer = @question.answers.new
  # end

  def create
    @answer = current_user.created_answers.new(answer_params)
    @answer.question_id = @question.id

    if @answer.save
      redirect_to @question, notice: 'Answer saved.'
    else
      redirect_to @question, notice: 'Answer NOT saved.'
    end
  end

  def destroy
    if @answer.author == current_user
      @answer.destroy
      redirect_to @answer.question, notice: "Answer deleted."
    else
      redirect_to @answer.question, notice: "You can't delete someone else's answer."
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
