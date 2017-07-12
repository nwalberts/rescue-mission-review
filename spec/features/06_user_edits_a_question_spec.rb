require "rails_helper"
require "pry"

feature "user edits a question" do
  before(:each) do
    @question = create(:question)
    @valid_title = "This is a test title This is a test title This is a test title This is a test title "
    @valid_description = "This is a test description This is a test description This is a test description This is a test description This is a test description This is a test description This is a test description This is a test description This is a test description This is a test description This is a test description This is a test description "
    @invalid_title = "This is an invalid test title"
    @invalid_description = "This is an invalid test description"
  end

  scenario "user visits the edit question form" do
    visit question_answers_path(@question)

    click_button "Edit Question"

    expect(current_path).to eq(edit_question_path(@question))
  end

  scenario "user enters valid information in the edit form" do
    visit edit_question_path(@question)

    fill_in('Title', with: @valid_title)
    fill_in('Description', with: @valid_description)

    click_button('Update Question')

    expect(page).to have_content(@valid_title)
    expect(page).to have_content(@valid_description)
  end

  context "invalid form submission" do
    scenario "user enters invalid title in the form" do
      visit edit_question_path(@question)

      fill_in('Title', with: @invalid_title)
      fill_in('Description', with: @valid_description)

      click_button('Update Question')

      expect(page).to have_content("Title is too short (minimum is 40 characters)")
    end
    scenario "user enters invalid description in the form" do
      visit edit_question_path(@question)

      fill_in('Title', with: @valid_title)
      fill_in('Description', with: @invalid_description)

      click_button('Update Question')

      expect(page).to have_content("Description is too short (minimum is 150 characters)")
    end

    scenario "user omits description in the form" do
      visit edit_question_path(@question)

      fill_in('Description', with: "")

      click_button('Update Question')

      expect(page).to have_content("Description can't be blank")
    end
    scenario "user omits title in the form" do
      visit edit_question_path(@question)

      fill_in('Title', with: "")

      click_button('Update Question')

      expect(page).to have_content("Title can't be blank")
    end
  end
end
