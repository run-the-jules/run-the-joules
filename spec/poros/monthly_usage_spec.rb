require 'rails_helper'

describe 'monthly usage' do
  before :each do
    @user = User.create(id: 1, household_size: 4, email: 'test5@gmail.com', total_points: 150,
    full_name: 'Tim Tyrell')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @data = { user_id: @user.id,
              start_date: '2015-02-19T23:00:00.000000-08:00',
              end_date: '2015-02-20T00:00:00.000000-08:00',
              kwh_usage: 456 }
  end

  it 'exists' do
    usage = MonthlyUsage.new(@data)
    expect(usage).to be_a MonthlyUsage
    expect(usage.end_date.to_date).to eq('Fri, 20 Feb 2015'.to_date)
    expect(usage.kwh).to eq(456)
    expect(usage.user).to eq(User.find(@data[:user_id]))
  end

  it 'calculate_monthly_points' do
    usage = MonthlyUsage.new(@data)

    expect(usage.monthly_points).to eq(100)
  end

  it 'calculate few monthly_points' do
    data2 = { user_id: @user.id,
              start: '2015-02-19T23:00:00.000000-08:00',
              end: '2015-02-20T00:00:00.000000-08:00',
              kwh: '9809238403' }

    usage = MonthlyUsage.new(data2)

    expect(usage.monthly_points).to eq(100)
  end
end
