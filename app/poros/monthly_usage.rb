class MonthlyUsage
  attr_reader :end_date,
              :monthly_points,
              :kwh,
              :user

  def initialize(usage_data)
    @end_date = usage_data[:end_date]
    @kwh = usage_data[:kwh].to_i
    @user = User.find(usage_data[:user_id] || usage_data[:friend_id])
    @monthly_points = calculate_monthly_points
  end

  def calculate_monthly_points
    points.select do |point|
      return point[:points] if (@kwh / @user.household_size) < point[:kwh]
    end
  end

  def points
    [{ kwh: 150, points: 100 },
     { kwh: 300, points: 75 },
     { kwh: 450, points: 50 },
     { kwh: 600, points: 25 },
     { kwh: Float::INFINITY, points: 5 }]
  end
end
