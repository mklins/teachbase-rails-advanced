require 'rails_helper'

feature 'Create answer', %q{
  In order to exchange my knowledge
  As an authenticated user
  I want to be able to create answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user tries to create new answer to the question', js: true do
    log_in(user)

    visit question_path(question)
    fill_in 'Your answer', with: 'Auth answer'
    click_on 'Submit answer!'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content 'Your answer was successfully created.'
    within '.answers' do
      expect(page).to have_content 'Auth answer'
    end
  end

  scenario 'Non-authenticated user tries to create new answer to the question', js: true do
    visit question_path(question)
    fill_in 'Your answer', with: 'Non-auth answer'
    click_on 'Submit answer!'

    expect(page).not_to have_content 'Non-auth answer'
  end

end