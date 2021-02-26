require 'rails_helper'

describe 'users facade' do
  context 'instance methods' do
    it 'returns a users usage' do
      user = User.create(email: 'test5@gmail.com', password: 'test5test5')
      usage = UsersFacade.find_usage(user.id)

      expect(usage).to be_a(Array)
      expect(usage.first[:data][:attributes][:usages]).to have_key(:kwh)
      expect(usage.first[:data][:attributes][:usages]).to have_key(:monthly_points)
    end
  end
end
