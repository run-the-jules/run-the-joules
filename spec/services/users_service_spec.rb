require 'rails_helper'

describe 'users service' do
  it 'returns utility info' do
    @user = User.create(id: 1, email: 'user@example.com',
                        password: 'password',
                        full_name: 'Tim Tool Man Taylor',
                        household_size: 3)
    usage_stub = File.read("spec/fixtures/usage_data.json")
    stub_request(:get, 'https://mysterious-ravine-39718.herokuapp.com/api/v1/1&household_size=3').
         to_return(status: 200, body: usage_stub)
    response = UsersService.call_utility(@user.id, @user.household_size)

    expect(response[:attributes][:usages].last).to have_key(:kwh)
    expect(response[:attributes][:usages].last).to have_key(:monthly_points)
    expect(response[:attributes][:usages].last).to have_key(:start)
    expect(response[:attributes][:usages].last).to have_key(:end)
  end
end
