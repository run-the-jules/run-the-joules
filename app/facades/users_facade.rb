class UsersFacade
  class << self
    def find_usage(id)
      usage = UsersService.call_utility(id)
      usage[:attributes][:usages].map do |monthly_usage|
        begin MonthlyUsage.new(monthly_usage)
        rescue StandardError
        end
      end
    end
  end
end
