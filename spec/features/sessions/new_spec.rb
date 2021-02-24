require 'rails_helper'

RSpec.describe 'new user session' do
  it 'has a link to log in' do
    visit root_path

    click_link('Log In')
    expect(current_path).to eq(login_path)
  end

  it 'allows user to login' do
    visit login_path

    user = User.create(email: 'test5@gmail.com', username: 'test_username', password: 'test5test5')

    expect(page).to have_link('Log In with Google')
    fill_in 'email', with: 'test5@gmail.com'
    fill_in 'password', with: 'test5test5'
    click_button 'Submit'
    expect(current_path).to eq(dashboard_user_path(user))
    expect(page).to have_content('You have successfully logged in')
  end

  it 'allows user access after sign in ' do
    user = User.create(email: 'test5@gmail.com', password: 'test5test5', username: 'test_username')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    user.authenticate(user.password)
    visit dashboard_user_path(user)
    expect(page).to have_content("Welcome, #{user.username}")
  end

  it 'will redirect the user if user is already logged in' do
    user = User.create(email: 'test5@gmail.com', password: 'test5test5', username: 'test_username')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    user.authenticate(user.password)

    visit login_path
    expect(current_path).to eq(dashboard_user_path(user.id))
    expect(page).to have_content('You are already logged in!')
  end

  it 'user is logged out if click_on logout' do
    visit login_path

    User.create(email: 'test5@gmail.com', password: 'test5test5', username: 'test_username')

    fill_in 'email', with: 'test5@gmail.com'
    fill_in 'password', with: 'test5test5'
    click_button 'Submit'
    expect(page).to have_link('Log Out')
    click_link 'Log Out'
    expect(page).to have_content('You are logged out')
  end

  it 'will kick back if incorrect login' do
    User.create(email: 'test5@gmail.com', password: 'test5test5', username: 'test_username')
    visit login_path

    fill_in 'email', with: 'test4@gmail.com'
    fill_in 'password', with: 'test4test4'
    click_button 'Submit'
    expect(page).to have_content('Invalid login credentials')
  end
end
