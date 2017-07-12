require 'rails_helper'

feature "post question" do
  scenario "user fills out form correctly and see posted question" do
    visit new_question_path

    fill_in 'Title', with: 'How much wood would a woodchuck chuck if a woodchuck could chuck wood?'
    fill_in 'Description', with: 'The nursery rhyme that every child learns at a young age in order to differentiate between a woodchuck as a noun and chuck as a verb and wood as a noun.  This is a silly little exercise to check to see if the form input is valid or not.'

    question_count = Question.count
    click_button('Create Question')

    expect(Question.count).not_to eq(question_count)

    expect(page).to have_content('How much wood')
    expect(page).to have_content('The nursery rhyme')
  end

  xscenario "user fills out form incorrectly and does not see posted question" do
    visit new_question_path

    # TODO update for failing

    fill_in 'Title', with: 'How much wood would a woodchuck chuck if a woodchuck could chuck wood?'
    fill_in 'Description', with: 'The nursery rhyme that every child learns at a young age in order to differentiate between a woodchuck as a noun and chuck as a verb and wood as a noun.  This is a silly little exercise to check to see if the form input is valid or not.'

    click_button("submit")

    expect(page).to have_content('How much wood')
    expect(page).to have_content('The nursery rhyme')
  end

end
