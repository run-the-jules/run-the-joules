require 'rails_helper'

describe 'users service' do
  it 'returns utility info' do
    @user = User.create(id: 1, email: 'user@example.com',
                        full_name: 'Tim Tool Man Taylor',
                        household_size: 3)
    usage_stub = File.read('spec/fixtures/usage_data.json')
    stub_request(:get, /usages/)
      .to_return(status: 200, body: usage_stub)
    response = UsersService.call_utility(@user.id)

    expect(response[:attributes][:usages].last).to have_key(:kwh)
    expect(response[:attributes][:usages].last).to have_key(:monthly_points)
    expect(response[:attributes][:usages].last).to have_key(:start)
    expect(response[:attributes][:usages].last).to have_key(:end)
  end

  it 'can get friends' do
    @user = User.create(id: 1, email: 'user@example.com',
    full_name: 'Tim Tool Man Taylor',
    household_size: 3)
    usage_stub_3 = File.read('spec/fixtures/friends.json')
    stub_request(:get, /friendship/).to_return(
      status: 200, body: usage_stub_3
    )

    response = UsersService.get_friends(@user.id)
    expect(response).to have_key(:data)

    response[:data].each do |friendship|
      expect(friendship).to have_key(:attributes)
      expect(friendship).to have_key(:id)
      expect(friendship[:attributes]).to have_key(:user_id)
      expect(friendship[:attributes]).to have_key(:following_id)
    end
  end

  it 'can get url' do
    @user = User.create(id: 1, email: 'user@example.com',
    full_name: 'Tim Tool Man Taylor',
    household_size: 3)
    usage_stub_3 = File.read('spec/fixtures/friends.json')
    stub_request(:get, /friendship/).to_return(
      status: 200, body: usage_stub_3
    )

    response = UsersService.new_user_utility(@user.email, "ACE")

    expect(response).to be_a(String)
  end

  it 'can request all meters' do

    @user = User.create(id: 1, email: 'user@example.com',
    full_name: 'Tim Tool Man Taylor',
    household_size: 3)

    meters = {"meter_uid":"711267"}.to_json
    stub_request(:get, /meters/).to_return(
      status: 200, body: meters
    )
    params = Hash.new
    params[:referral] = 186139
    params[:id] = @user.id
    response = UsersService.get_meters(params)

    expect(response).to have_key(:meter_uid)
  end

  it 'can get usages' do

    user = User.create(id: 1, email: 'user@example.com',
    full_name: 'Tim Tool Man Taylor',
    household_size: 3)

    usages = File.read('spec/fixtures/usages.json')
    stub_request(:get, /friendships/).to_return(
      status: 200, body: usages
    )

    response = UsersService.get_usages(user.id)

    expect(response).to have_key(:data)
    response[:data].each do |usage|
      expect(usage).to have_key(:attributes)
    end
  end
end