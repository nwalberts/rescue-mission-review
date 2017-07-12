require "rails_helper"

feature "views question details with answers" do
  before(:each) do
    @question = create(:question)
    @question2 = create(:question)
    @answer1 = create(:answer, question: @question)
    @answer2 = create(:answer, question: @question)
    @answer3 = create(:answer, question: @question)
    @answer4 = create(:answer, question: @question2)
  end

  scenario "sees description for all answers" do
    visit question_answers_path(@question)

    expect(page).to have_content(@answer1.description)
    expect(page).to have_content(@answer2.description)
    expect(page).to have_content(@answer3.description)
  end

  scenario "does not see answers for different questions" do
    visit question_answers_path(@question)
    # save_and_open_page

    expect(page).to_not have_content(@answer4.description)
  end

  scenario "sees all answers in reverse chronological order" do
    visit question_answers_path(@question)

    expect page.body.index(@question.answers[1].description) < page.body.index(@question.answers[0].description)
    expect page.body.index(@question.answers[2].description) < page.body.index(@question.answers[1].description)
  end
end
