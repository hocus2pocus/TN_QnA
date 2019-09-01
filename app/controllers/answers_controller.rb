class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: %i[new create]
  before_action :load_answer, only: %i[show edit update destroy]
  before_action :check_for_author, only: %i[update destroy]

  # def index
  #   @answers = @question.answers.all
  # end

  # def show
  # end

  # def new
  #   @answer = @question.answers.new
  # end

  def create
    @answer = current_user.answers.new(answer_params)
    @answer.question = @question

    if @answer.save
      redirect_to @question, notice: 'Answer saved.'
    else
      @answers = @question.answers.all
      flash.now[:alert] = 'Answer NOT saved.'
      render 'questions/show'
    end
  end

  def destroy
    # if current_user.author?(@answer)
    #   @answer.destroy
    #   redirect_to @answer.question, notice: "Answer deleted."
    # else
    #   redirect_to @answer.question, notice: "You can't delete someone else's answer."
    # end

    @answer.destroy
    redirect_to @answer.question, notice: "Answer deleted."
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

  def check_for_author
    unless current_user.author?(@answer)
      redirect_to @answer.question, notice: "Only an author can do this."
    end
  end
end
