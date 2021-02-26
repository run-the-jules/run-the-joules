class UsersFacade
  class << self
    def find_usage(id, size)
      usage = UsersService.call_utility(id, size)
    end
  end
end
