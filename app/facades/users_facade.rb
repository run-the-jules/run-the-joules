class UsersFacade
  class << self
    def find_usage(id, size)
      usage = UsersService.call_utility(id, size)
      usage[:attributes][:usages].map do |monthly_usage|
        MonthlyUsage.new(monthly_usage)
      end
    end
  end
end
