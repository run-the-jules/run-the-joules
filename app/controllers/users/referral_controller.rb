class Users::ReferralController < ApplicationController
  before_action :check_user
  def index
    if params[:referral]
      begin
        @message = UsersService.get_meters(params)
      rescue
        flash[:notice] = "Something went wrong"
      end
    end
  end
end