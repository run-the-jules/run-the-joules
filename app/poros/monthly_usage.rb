class MonthlyUsage
  attr_reader :end_date,
              :monthly_points,
              :kwh,
              :user,
              :name

  def initialize(usage_data)
    @end_date = (usage_data[:end_date] || Date.today)
    @kwh = (usage_data[:kwh_usage].to_i || usage_data[:user_kwh].to_i || nil)
    @user = User.find(usage_data[:user_id] || usage_data[:friend_id])
    @name = @user.full_name
    @monthly_points = calculate_monthly_points
  end

  def calculate_monthly_points
    if @kwh > 0
      points.select do |point|
        return point[:points] if (@kwh / @user.household_size) < point[:kwh]
      end
    else
      0
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
