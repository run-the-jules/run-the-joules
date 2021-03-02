require 'rails_helper'

RSpec.describe 'new user session' do
  it 'has a link to log in' do
    visit root_path

    click_link('Log In')
    expect(current_path).to eq(new_user_session_path)
  end

  xit 'allows user to login' do
    visit new_user_session_path

    user = User.create(email: 'test5@gmail.com', password: 'test5test5')
    expect(page).to have_link('Sign in with Google')
    click_on 'Sign in with Google'
    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content('You have successfully logged in')
  end

  xit 'allows user access after sign in ' do
    user = User.create(email: 'test5@gmail.com', password: 'test5test5')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    user.authenticate(user.password)
    visit dashboard_index_path
    expect(page).to have_content("Welcome, #{user.username}")
  end

  xit 'will redirect the user if user is already logged in' do
    user = User.create(email: 'test5@gmail.com', password: 'test5test5')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    user.authenticate(user.password)

    visit new_user_session_path
    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content('You are already logged in!')
  end

  xit 'user is logged out if click_on logout' do
    visit new_user_session_path

    User.create(email: 'test5@gmail.com', password: 'test5test5')

    fill_in 'email', with: 'test5@gmail.com'
    fill_in 'password', with: 'test5test5'
    click_button 'Submit'
    expect(page).to have_link('Log Out')
    click_link 'Log Out'
    expect(page).to have_content('You are logged out')
  end

  xit 'will kick back if incorrect login' do
    User.create(email: 'test5@gmail.com', password: 'test5test5')
    visit new_user_session_path

    fill_in 'email', with: 'test4@gmail.com'
    fill_in 'password', with: 'test4test4'
    click_button 'Submit'
    expect(page).to have_content('Invalid login credentials')
  end
end
