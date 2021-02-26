class MonthlyUsage
  attr_reader :end_date, :monthly_points, :kwh
  def initialize(usage_data)
    @end_date = usage_data[:end].to_date
    @monthly_points = usage_data[:monthly_points]
    @kwh = usage_data[:kwh]
  end
end
