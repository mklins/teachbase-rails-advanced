require 'rails_helper'

feature 'View all questions', %q{
  In order to see the list of all questions
  As any user
  I want to be able to see questions
} do
  
  let!(:questions) { create_list(:question, 3) }
  
  given(:user) { create(:user) }

  scenario 'Non-authenticated user visits questions index' do
    visit questions_path

    expect(page).to have_content(questions[0].title)
    expect(page).to have_content(questions[1].title)
    expect(page).to have_content(questions[2].title)
  end

  scenario 'Authenticated user tries to create question' do
    log_in(user)

    visit questions_path

    expect(page).to have_content(questions[0].title)
    expect(page).to have_content(questions[1].title)
    expect(page).to have_content(questions[2].title)
  end

end