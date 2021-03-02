class Users::SessionsController < Devise::SessionsController
  def create
    super
  end

  protected

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  # def after_sign_in_path_for(resource)
  #   user_dashboard_path(resource)
  # end
end
