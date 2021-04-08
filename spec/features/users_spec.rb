require 'rails_helper'

RSpec.feature "Users", type: :feature do
  context 'signing up:' do
    scenario 'sign up succesfully' do
      visit new_user_registration_path
      fill_in 'Name', with: 'Franklin'
      fill_in 'Email', with: 'franklin23@gmail.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'
      visit root_path
      expect(page).to have_content('Franklin')
    end
  
    scenario 'unsuccesfully sign up' do
      visit new_user_registration_path
      fill_in 'Name', with: ''
      fill_in 'Email', with: 'franklin23@gmail.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'
      visit root_path
      expect(page).to_not have_content('Franklin')
    end
  end

  context 'loging in:' do
    let(:user) { User.create(name: 'Franklin', email: 'franklin@gmail.com', password: '12345678') }
    scenario 'succesfully log in' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      expect(page).to have_content('Franklin')
    end

    scenario 'unsuccesfully log in' do
      visit new_user_session_path
      fill_in 'Email', with: 'benjamin'
      fill_in 'Password', with: user.password
      click_on 'Log in'
      expect(page).to_not have_content('Franklin')
    end
  end

  context 'log out' do
    let(:user) { User.create(name: 'Franklin', email: 'franklin@gmail.com', password: '12345678') }
    scenario 'Log Out' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      click_on 'Sign Out'
      visit root_path
      expect(page).to have_content('Sign In')
    end
  end
end
