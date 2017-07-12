require "rails_helper"

feature "user answers a question" do
  let! (:question) {create(:question)}
  let (:valid_description) {Faker::Lorem.characters(50)}
  let (:invalid_description) {Faker::Lorem.characters(30)}

  scenario "user visits the the question show page and sees answer form" do
    visit question_answers_path(question.id)

    expect(page).to have_field("answer_description", placeholder: "Your Answer Here")
  end

  scenario "user enters valid information in the form" do
    visit question_answers_path(question.id)

    fill_in('answer_description', with: valid_description)

    answer_list_length = Answer.count

    click_button('Post Answer')

    expect(Answer.count).not_to eq(answer_list_length)
    expect(Answer.last.description).to eq(valid_description)
  end

  context "invalid form submission" do
    scenario "user enters invalid description in the form" do
      visit question_answers_path(question.id)

      fill_in('answer_description', with: invalid_description)

      click_button('Post Answer')

      expect(page).to have_content("Description is too short (minimum is 50 characters)")
    end
    scenario "user omits description in the form" do
      visit question_answers_path(question.id)

      click_button('Post Answer')

      expect(page).to have_content("Description can't be blank")
    end
  end
end
