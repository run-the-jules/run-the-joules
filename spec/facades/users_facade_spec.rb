require 'rails_helper'

describe 'users facade' do
  context 'instance methods' do
    it 'returns a users usage' do
      user = User.create(email: 'test5@gmail.com', password: 'test5test5', household_size: 3, id: 1)

      usage_stub = File.read('spec/fixtures/usage_data.json')
      stub_request(:get, "https://jules-api.herokuapp.com/api/v1/usages?id=#{user.id}")
        .to_return(status: 200, body: usage_stub)

      usage = UsersFacade.find_usage(user.id)

      expect(usage).to be_an(Array)

      expect(usage.last.kwh).to eq(123_456)
      expect(usage.last.monthly_points).to eq(5)
    end
  end
end
