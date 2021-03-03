class UsersFacade
  class << self
    def find_usage(id)
      usages = UsersService.call_utility(id)
      usages[:data].map do |usage|
        MonthlyUsage.new(usage[:attributes])
      end
    end
  end
end
