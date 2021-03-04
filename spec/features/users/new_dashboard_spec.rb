require 'rails_helper'

RSpec.describe 'dashboard index' do
  describe 'it will take in params and return usable data' do
    it 'can find friends usages', :vcr do
      user1 = User.create!(id: 1, email: 'test83@gmail.com', total_points: 150,
      full_name: 'Catherine Dean', household_size: 5)
      user2 = User.create!(id: 2, email: 'test48@gmail.com', total_points: 150,
      full_name: 'Catherine Dean', household_size: 1)
      user3 = User.create!(id: 3, email: 'test28@gmail.com', total_points: 150,
      full_name: 'Catherine Dean', household_size: 8)
      user4 = User.create!(id: 4, email: 'test81@gmail.com', total_points: 150,
      full_name: 'Catherine Dean', household_size: 2)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
        login_as user1


      visit dashboard_index_path

      expect(page).to have_content("Friends")
    end
  end
end