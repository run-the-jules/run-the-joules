class Users::ReferralController < ApplicationController
  before_action :check_user
  def index
    begin
      @message = UsersService.get_meters(params)
    rescue
      flash[:notice] = "Something went wrong"
    end
  end
end