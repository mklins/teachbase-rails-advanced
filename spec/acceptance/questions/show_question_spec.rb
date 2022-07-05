require 'rails_helper'

feature 'Show question with answers', %q{
  In order to see question and answers from community
  As an authenticated user
  I want to be able to see question and answers for it
} do

  let!(:question) { create(:question) }
  let!(:answers) { create_list(:answer, 2, question: question) }

  given(:user) { create(:user) }

  scenario 'Authenticated user observes question and answers to it' do
    log_in(user)

    visit question_path(question)

    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)
    expect(page).to have_content(question.answers.first.body)
    expect(page).to have_content(question.answers.second.body)
  end

  scenario 'Non-authenticated user observes question and answers to it' do
    visit question_path(question)

    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)
    expect(page).to have_content(question.answers.first.body)
    expect(page).to have_content(question.answers.second.body)
  end

end