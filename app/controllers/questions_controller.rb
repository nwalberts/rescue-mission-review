class QuestionsController < ApplicationController
  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      flash[:success] = "Question saved successfully."
      redirect_to question_path(@question)
    else
      flash[:alert] = @question.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      flash[:success] = "Question saved successfully."
      redirect_to question_answers_path(@question)
    else
      flash[:alert] = @question.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.destroy!
      flash[:notice] = "Question been destroyed!"
      redirect_to questions_path
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :description)
  end
end
