require 'rails_helper'

RSpec.describe 'welcome page' do
  it 'has a welcome message and brief description of the application' do
    visit root_path

    expect(page).to have_content('Welcome to Run the Joules')
    expect(page).to have_content('Run the Joules is an app that allows you to compare your energy usage with your friends!')
    expect(page).to have_link('Log In')
    expect(page).to have_link('Home')
  end
end
