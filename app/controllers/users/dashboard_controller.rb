class Users::DashboardController < ApplicationController
  before_action :check_user
  before_action :check_household

  def index
    begin
      @data_info_usage = DashboardFacade.build_usages(params, current_user)

    rescue
    end
  end

  # def index
  #   params[:id] = current_user.id
  #   if current_user.friends
  #     @friends = current_user.friends.flat_map do |friend|
  #       begin UsersFacade.find_usage(friend.id)
  #       rescue
  #       end
  #     end
  #   end
  # end

  private

  def check_household
    redirect_to edit_user_path(current_user) unless current_user.household_size
  end
end