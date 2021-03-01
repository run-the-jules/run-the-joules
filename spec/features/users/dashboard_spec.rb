require 'rails_helper'

describe 'dashboard' do
  describe 'happy path' do
    before :each do
      @user = User.create(household_size: 3, email: 'test5@gmail.com', password: 'test5test5', total_points: 150,
                          full_name: 'Tim Tyrell', id: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      usage_stub_1 = File.read('spec/fixtures/usage_data.json')
      stub_request(:get, "https://mysterious-ravine-39718.herokuapp.com/api/v1/#{@user.id}")
        .to_return(status: 200, body: usage_stub_1)

      usage_stub_2 = File.read('spec/fixtures/utilities.json')
      something = true
      stub_request(:get, "https://mysterious-ravine-39718.herokuapp.com/api/vi/meter_activation?utilities=#{something}").to_return(
        status: 200, body: usage_stub_2
      )
    end

    it 'takes us to the user data' do
      visit dashboard_user_path(@user)

      expect(page).to have_content(@user.total_points)
      expect(page).to have_content(@user.full_name)
    end

    it 'has a drop down list of available utilities' do
      visit dashboard_user_path(@user)

      expect(page).to have_content('Xcel Energy')
      expect(page).to have_content('Atlantic City Electric')

      select 'Xcel Energy', from: 'provider'
      click_button 'Authorize Provider'

      expect(current_path).to eq(dashboard_user_path(current_user))
    end
  end

  describe 'redirect path' do
    it 'redirects to edit page if user has not entered household_size' do
      user2 = User.create!(email: 'test8@gmail.com', password: 'test5test5', total_points: 150,
                           full_name: 'Catherine Dean')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

      usage_stub_1 = File.read('spec/fixtures/usage_data.json')
      stub_request(:get, "https://mysterious-ravine-39718.herokuapp.com/api/v1/#{user2.id}")
        .to_return(status: 200, body: usage_stub_1)

      usage_stub_2 = File.read('spec/fixtures/utilities.json')
      something = true
      stub_request(:get, "https://mysterious-ravine-39718.herokuapp.com/api/vi/meter_activation?utilities=#{something}")
        .to_return(status: 200, body: usage_stub_2)

      visit user_google_oauth2_omniauth_callback_path(user2)

      expect(current_path).to eq(edit_user_path(user2))
    end
  end
end
