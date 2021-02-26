require 'rails_helper'

describe 'dashboard' do
  before :each do
    @user = User.create(email: 'test5@gmail.com', password: 'test5test5', household_size: 3, id: 1, full_name: 'Tim Tyrell', total_points: 225)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'takes us to the user data' do
    usage_stub = File.read("spec/fixtures/usage_data.json")
    stub_request(:get, 'https://mysterious-ravine-39718.herokuapp.com/api/v1/1&household_size=3').to_return(status: 200, body: usage_stub)

    visit dashboard_user_path(@user)

    expect(page).to have_content(@user.total_points)
    expect(page).to have_content(@user.full_name)
    expect(page).to have_content("Monthly Points: 150")
    expect(page).to have_content("February's usage: 123456 kwh")
  end
end
