class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :check_for_author, only: [:update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answers = @question.answers
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def edit
    unless current_user.author?(@question)
      redirect_to @question, notice: "You can't edit someone else's question."
    end
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      flash.now[:alert] = 'Question NOT saved.'
      render :new
    end
  end

  def update
    # if current_user.author?(@question)
    #   if @question.update(question_params)
    #     redirect_to @question, notice: "Question edited."
    #   else
    #     render :edit
    #   end
    # else
    #   redirect_to @question, notice: "You can't edit someone else's question."
    # end

    if @question.update(question_params)
      redirect_to @question, notice: "Question edited."
    else
      render :edit
    end
  end

  def destroy
    # if current_user.author?(@question)
    #   @question.destroy
    #   redirect_to questions_path, notice: "Question deleted."
    # else
    #   redirect_to @question, notice: "You can't delete someone else's question."
    # end

    @question.destroy
    redirect_to questions_path, notice: "Question deleted."
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def check_for_author
    unless current_user.author?(@question)
      redirect_to @question, notice: "Only an author can do this."
    end
  end
end
