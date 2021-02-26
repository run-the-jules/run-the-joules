require 'rails_helper'

describe 'dashboard' do
  before :each do
    @user = User.create(email: 'test5@gmail.com', password: 'test5test5', total_points: 150, full_name: "Tim Tyrell")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'takes us to the user data' do
    visit dashboard_user_path(@user)

    expect(page).to have_content(@user.total_points)
    expect(page).to have_content(@user.full_name)
    expect(page).to have_content(@user.monthly_points)

  end
end
