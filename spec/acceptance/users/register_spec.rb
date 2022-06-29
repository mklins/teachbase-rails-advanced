require 'rails_helper'

feature 'User register', %q{
  In order to be able to register a new user
  As an unregistered user
  I want to able to register
} do

  given(:user) { create(:user) }
  
  scenario 'Non-registered user try to sign up' do
    usercount = User.count

    visit new_user_registration_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'

    click_on 'Sign up'
    #save_and_open_page

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(User.count).to eq(usercount+1)
    expect(current_path).to eq(root_path)
  end

  scenario 'Registered user try to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password

    click_on 'Sign up'
    #save_and_open_page

    expect(page).to have_content('1 error prohibited this user from being saved:')
    expect(current_path).to eq(user_registration_path)
  end

end
