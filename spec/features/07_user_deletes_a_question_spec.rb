require "rails_helper"

feature "user deletes a question" do
  before(:each) do
    @question = create(:question)
    @current_question_total = Question.count
    3.times do
      create(:answer, question: @question)
    end
  end

  scenario "user visits the show question form" do
    visit question_answers_path(@question)

    click_button "Delete Question"

    expect(Question.count).to eq(@current_question_total-1)
    expect(Question.exists?(@question.id)).to eq(false)
  end

  scenario "user visits the edit question form" do
    visit edit_question_path(@question)

    click_button "Delete Question"

    expect(Question.count).to eq(@current_question_total-1)
    expect(Question.exists?(@question.id)).to eq(false)
  end

  scenario "all associated answers are also deleted when a question is deleted" do
    visit question_answers_path(@question)

    click_button('Delete Question')

    expect(Answer.where(question_id: @question.id)).to eq([])
  end

end
