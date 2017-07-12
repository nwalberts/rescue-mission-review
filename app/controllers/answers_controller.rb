class AnswersController < ApplicationController

  def index
    @question = Question.find(params[:question_id])
    # @answers = @question.answers.order(best: :desc, created_at: :desc)
    @answers = @question.answers.order(created_at: :desc)
    @answer = Answer.new
  end

  # def new
  #   @question = Question.find(params[:question_id])
  #   @answer = Answer.new
  # end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question

    if @answer.save
      flash[:success] = "Answer saved correctly."
      # redirect_to question_answers_path(@question)
      redirect_to question_path(@question)
    else
      flash[:alert] = @answer.errors.full_messages.to_sentence
      # redirect_to question_answers_path(@question)
      redirect_to question_path(@question)
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @question = @answer.question

    @question.answers.each do |answer|
      answer.best = false
      answer.save
    end
    @answer.best = true

    if @answer.save
      flash[:success] = "Best answer updated!"
      # redirect_to question_answers_path(@answer.question)
      redirect_to question_path(@question)
    else
      flash[:alert] = "Error updating your answer"
      # redirect_to question_answers_path(@answer.question)
      redirect_to question_path(@question)

    end
  end

  private

  def answer_params
    params.require(:answer).permit(:description)
  end
end
