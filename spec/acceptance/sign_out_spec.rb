require 'rails_helper'

feature 'User sign out', %q{
  In order to be able to maybe change account
  As an user
  I want to able to sign out
} do
  
  scenario 'User try to sign out' do
    @user = create(:user)
    sign_in @user

    visit destroy_user_session_path

    expect(page).to have_content('Signed out successfully.')
    expect(current_path).to eq(root_path)
  end

end