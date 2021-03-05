require 'rails_helper'

RSpec.describe "Friends show page" do
  describe "(happy path)" do
    # add some data
    before(:each) do
      @leslie = User.create!(household_size: 4, email: 'somebody@example.com', total_points: 500,
      full_name: 'Leslie Knope', id: 1)
  
      @ron = User.create!(household_size: 3, email: 'new_person@example.com', total_points: 500,
      full_name: 'Ron Swanson', id: 2)
  
      @anne = User.create!(household_size: 1, email: 'another_person@example.com', total_points: 500,
      full_name: 'Anne Perkins', id: 3)
  
      @tom = User.create!(household_size: 1, email: 'tom_h@example.com', total_points: 500,
      full_name: 'Tom Haverford', id: 4)

      @ben = User.create!(household_size: 1, email: 'ben@pnr.gov', total_points: 5,
      full_name: 'Ben Wyatt', id: 5)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@leslie)

      login_as(@leslie)

      # friends_stub = File.read('spec/fixtures/friends.json')
      
      # stub_request(:get, /friendships/).to_return(
      #   status: 200, body: friends_stub
      # )

      visit dashboard_index_path
    end

    it "lists a user's friends and their stats" do
      VCR.use_cassette("users_friends") do
        expect(page).to have_content("#{@ron.full_name}: 50 points this month")
        expect(page).to have_content("#{@anne.full_name}: 50 points this month")
        expect(page).to have_content("#{@tom.full_name}: 5 points this month")
      end
    end

    it "lets user add friends" do
      VCR.use_cassette("user_search") do

        within("#add-friend-section") do
          fill_in :query, with: @ben.email
          click_button('Follow Friend')
        end

        expect(page).to have_content("You are now following #{@ben.full_name}!")
        expect(page).to have_content("#{@ben.full_name}: 5 points this month")
      end
    end
  end
  
  describe "(sad path)" do
    before(:each) do
      @ben = User.create!(household_size: 1, email: 'ben@pnr.gov', total_points: 5,
      full_name: 'Ben Wyatt', id: 5)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@ben)
      login_as(@ben)

      visit dashboard_index_path
    end

    it "user gets error when email doesn't exist" do
      VCR.use_cassette("missing_an_email") do

        within('#add-friend-section') do
          fill_in :query, with: "nobody@email.com"
          click_button('Follow Friend')
        end
      
        expect(page).to have_content("User doesn't exist!")
      end
    end

    it "Provides a message that a user doesn't currently have friends if they haven't added anyone" do
      expect(page).to have_content("You currently have no friends.")
    end
  end
end