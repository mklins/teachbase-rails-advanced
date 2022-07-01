require 'rails_helper'

feature 'Create answer', %q{
  In order to exchange my knowledge
  As an authenticated user
  I want to be able to create answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user tries to create new answer to the question' do
    log_in(user)

    visit question_path(question)
    fill_in 'Your answer', with: 'Test answer'
    click_on 'Submit answer!'

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content 'Your answer was successfully created.'
    within '.answers' do
      expect(page).to have_content 'Test answer'
    end
  end

  scenario 'Non-authenticated user tries to create new answer to the question' do
    visit question_path(question)
    fill_in 'Your answer', with: 'Test answer'
    click_on 'Submit answer!'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end