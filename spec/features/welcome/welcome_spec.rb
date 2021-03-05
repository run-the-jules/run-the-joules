require 'rails_helper'

RSpec.describe 'welcome page' do
  it 'has a welcome message and brief description of the application' do
    visit root_path

    expect(page).to have_content('Welcome to Run the Joules')
    expect(page).to have_content('Run the Joules is an app that allows you to compare your energy usage with your friends!')
    expect(page).to have_link('Log In')
    expect(page).to have_link('Home')
  end

  it "redirects to dashboard if user is logged in" do
    @leslie = User.create!(household_size: 4, email: 'somebody@example.com', total_points: 500,
      full_name: 'Leslie Knope', id: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@leslie)
    login_as(@leslie)

    visit root_path
    expect(current_path).to eq(dashboard_index_path)
  end
end
