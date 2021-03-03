require 'rails_helper'

describe 'users facade' do
  context 'instance methods' do
    it 'returns a users usage' do
      user = User.create(email: 'test5@gmail.com', household_size: 3, id: 1)

      usage_stub = File.read('spec/fixtures/usage_data.json')
      stub_request(:get, /usages/)
        .to_return(status: 200, body: usage_stub)

      usage = UsersFacade.find_usage(user.id)

      expect(usage).to be_an(Array)

      expect(usage.last.kwh).to eq(123_456)
      expect(usage.last.monthly_points).to eq(5)
    end

    xit 'returns a friends usage' do
      user = User.create(email: 'test5@gmail.com', household_size: 3, id: 1)
      user2 = User.create(email: 'test5@gmail.com', household_size: 3, id: 4)
      usage_stub_3 = File.read('spec/fixtures/friends.json')
      stub_request(:get, /friendship/).to_return(
        status: 200, body: usage_stub_3
      )
      usage_stub = File.read('spec/fixtures/usage_data.json')
      stub_request(:get, /usages/)
        .to_return(status: 200, body: usage_stub)

      usage = UsersFacade.friends_usage(user.id)

      expect(usage).to be_an(Array)

      expect(usage.last.kwh).to eq(123_456)
      expect(usage.last.monthly_points).to eq(5)
    end
  end
end
