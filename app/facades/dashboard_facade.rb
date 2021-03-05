class DashboardFacade
  class << self
    def build_usages(params, user)
      our_usages = UsersService.get_usages(user.id)[:data][:attributes]
      usages = {user_usage: MonthlyUsage.new(our_usages),
                friends: our_usages[:friends_data].map do |friend|
                  friend[:user_id] = friend[:friend_id]
                  MonthlyUsage.new(friend)
                end
                }
      usages
    end

    def user_usage(params)
      params[:kwh_usage] = params[:kwh]
      MonthlyUsage.new(params)
    end
  end
end