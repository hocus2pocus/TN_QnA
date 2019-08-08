class AnswersController < ApplicationController
  # before_action :load_question
  before_action :load_answer, only: %i[show edit update destroy]

  def index
    @answers = Answer.all
  end

  def show
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end
end
