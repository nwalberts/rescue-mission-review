require "rails_helper"

feature "user marks a best answer" do
  before(:each) do
    @question = create(:question)
    3.times do
      create(:answer, question: @question)
    end
  end

  scenario "user marks an answer as the best" do
    visit question_answers_path(@question)

    within first(".answer") do
      click_button('Best Answer')
    end

    expect(@question.answers.last.best).to eq(true)

    bad_answer_array = @question.answers.select { |answer| !answer.best? }
    expect(bad_answer_array.length).to eq(2)
  end

  scenario "user sees best answer at top of list" do
    visit question_answers_path(@question)
    within all(".answer").last do
      click_button('Best Answer')
    end
    binding.pry

    # expect first(".answer").to have_css("answer card best")

    expect page.body.index(@question.answers[0].description) < page.body.index(@question.answers[1].description)
    expect page.body.index(@question.answers[0].description) < page.body.index(@question.answers[2].description)
  end

end
