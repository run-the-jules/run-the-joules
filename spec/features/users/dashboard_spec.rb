require 'rails_helper'

describe 'dashboard' do
  describe 'happy path' do
    before :each do
      @user = User.create!(id: 1, email: 'test83@gmail.com', total_points: 150,
      full_name: 'Catherine Dean', household_size: 5)
      user2 = User.create!(id: 2, email: 'test48@gmail.com', total_points: 150,
      full_name: 'Catherine Dean', household_size: 1)
      user3 = User.create!(id: 3, email: 'test28@gmail.com', total_points: 150,
      full_name: 'Catherine Dean', household_size: 8)
      user4 = User.create!(id: 4, email: 'test81@gmail.com', total_points: 150,
      full_name: 'Catherine Dean', household_size: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      friendships = File.read('spec/fixtures/friends.json')
      stub_request(:get, /friendship/).to_return(
        status: 200, body: friendships
      )
      usage_stub_2 = File.read('spec/fixtures/usage_data.json')
      stub_request(:get, /friendships?user_id/).to_return(
        status: 200, body: usage_stub_2
      )
    end

    it 'has a drop down list of available utilities', :vcr do
      usage_stub_3 = File.read('spec/fixtures/utilities.json')
      stub_request(:get, /friendships?user_id/).to_return(
        status: 200, body: usage_stub_3
      )


      visit dashboard_index_path

      expect(page).to have_content('Xcel Energy')
      expect(page).to have_content('Atlantic City Electric')
    end
  end
  
  describe 'it can redirect if already signed in' do
    it 'redirects if you are signed in', :vcr do
      user2 = User.create!(id: 1, email: 'test8@gmail.com', total_points: 150,
      full_name: 'Catherine Dean', household_size: 5)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
        login_as user2

        visit root_path

        expect(current_path).to eq(dashboard_index_path)
    end


    it 'redirects if signed in', :vcr do
      user2 = User.create!(id: 1, email: 'test8@gmail.com', total_points: 150,
      full_name: 'Catherine Dean', household_size: 5)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
        login_as user2

        visit root_path

        expect(current_path).to eq(dashboard_index_path)
    end
  end

  describe 'redirect path' do
    it 'redirects to edit page if user has not entered household_size' do
      user2 = User.create!(email: 'test8@gmail.com', total_points: 150,
                           full_name: 'Catherine Dean')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
      login_as user2

      visit dashboard_index_path

      expect(current_path).to eq(edit_user_path(user2))

      fill_in :user_household_size, with: 5

      click_on "Update User"

      usage_stub_1 = File.read('spec/fixtures/usage_data.json')
      stub_request(:get, /usages/)
        .to_return(status: 200, body: usage_stub_1)

      usage_stub_2 = File.read('spec/fixtures/utilities.json')
      stub_request(:get, /providers/)
        .to_return(status: 200, body: usage_stub_2)

      expect(current_path).to eq(dashboard_index_path)
    end

    it 'redirects to edit page if user has not entered household_size' do
      user2 = User.create!(email: 'test8@gmail.com', total_points: 150,
                           full_name: 'Catherine Dean')
      user3 = User.create!(email: 'test28@gmail.com', total_points: 150,
                           full_name: 'Catherine Dean')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
      login_as user2
      usage_stub_3 = File.read('spec/fixtures/friends.json')
      stub_request(:get, /friendship/).to_return(
        status: 200, body: usage_stub_3
      )
      usage_stub_1 = File.read('spec/fixtures/usage_data.json')
      stub_request(:get, /usages/)
        .to_return(status: 200, body: usage_stub_1)

      usage_stub_2 = File.read('spec/fixtures/utilities.json')
      stub_request(:get, /providers/)
        .to_return(status: 200, body: usage_stub_2)

      visit dashboard_index_path

      expect(current_path).to eq(edit_user_path(user2))
    end

    it 'it will get meters with a referral code' do
      user2 = User.create!(email: 'test8@gmail.com', total_points: 150,
                           full_name: 'Catherine Dean', household_size: 5)
      user3 = User.create!(email: 'test28@gmail.com', total_points: 150,
                           full_name: 'Catherine Dean')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
      login_as user2

      usage_stub_3 = File.read('spec/fixtures/friends.json')
      stub_request(:get, /friendship/).to_return(
        status: 200, body: usage_stub_3
      )
      usage_stub_1 = File.read('spec/fixtures/usage_data.json')
      stub_request(:get, /usages/)
        .to_return(status: 200, body: usage_stub_1)

        usage_stub_5 = File.read('spec/fixtures/usages.json')
        stub_request(:get, /get_bills/)
          .to_return(status: 200, body: usage_stub_5)
  
      usage_stub_2 = File.read('spec/fixtures/utilities.json')
      stub_request(:get, /providers/)
        .to_return(status: 200, body: usage_stub_2)

        meters = {"meter_uid":"711267"}.to_json
        stub_request(:get, /meters/).to_return(
        status: 200, body: meters
        )

      visit dashboard_index_path(referral: 186139)

      expect(current_path).to eq(dashboard_index_path)
    end

    it 'current_user has friends', :vcr do
      user2 = User.create!(email: 'test8@gmail.com', total_points: 150,
                           full_name: 'Catherine Dean', household_size: 5)
                           user2 = User.create!(id: 4, email: 'test38@gmail.com', total_points: 150,
                           full_name: 'Dean', household_size: 5)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
      login_as user2
      usage_stub_3 = File.read('spec/fixtures/friends.json')
      stub_request(:get, /friendship/).to_return(
        status: 200, body: usage_stub_3
      )
      usage_stub_1 = File.read('spec/fixtures/usage_data.json')
      stub_request(:get, /usages/)
        .to_return(status: 200, body: usage_stub_1)

      # usage_stub_2 = File.read('spec/fixtures/utilities.json')
      # stub_request(:get, /providers/)
      #   .to_return(status: 200, body: usage_stub_2)

      visit dashboard_index_path

      expect(current_path).to eq(dashboard_index_path)
    end
  end
end
