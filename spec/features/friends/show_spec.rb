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
      full_name: 'Anne Haverford', id: 4)

      @ben = User.create!(household_size: 1, email: 'ben@pnr.gov', total_points: 5,
      full_name: 'Ben Wyatt', id: 5)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@leslie)

      login_as(@leslie)

      friends_stub = File.read('spec/fixtures/friends_2.json')
      
      stub_request(:get, "/api/v1/friendships?user_id=1").to_return(
        status: 200, body: friends_stub
      )


      visit user_friends_path(@leslie)
    end


    it "Lists a user's friends and their stats" do

      expect(page).to have_content(@ron.full_name)
      expect(page).to have_content(@anne.full_name)
      expect(page).to have_content(@tom.full_name)
    end

    it "lets user add friends" do
      within('#add-user-panel') do
        expect(page).to have_content("Add user")
        fill_in "friend", with: @ben.email
        click_button('Add')
      end

      expect(page).to have_content("You're now following #{@ben.full_name}!")

      within("#user-#{@ben.id}-section") do
        expect(page).to have_content("5")
      end
    end

  end
  
  describe "(sad path)" do
    it "user gets error when email doesn't exist" do
      visit user_friend_path(1)

      within('#add-user-panel') do
        expect(page).to have_content("Add user")
        fill_in "friend", with: "nobody@email.com"
        click_button('Add')
      end
    
      expect(page).to have_content("We can't find a user with that email.")
    end

    xit "Provides a message that a user doesn't currently have friends if they haven't added anyone" do
    
    end
  end
end