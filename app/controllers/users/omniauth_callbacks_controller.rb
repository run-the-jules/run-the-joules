class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def google_oauth2
    user = User.from_google(from_google_params)
    if user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in(user)
      session[:user_id] = user.id
      if user.household_size
        redirect_to dashboard_index_path
      else
        redirect_to edit_user_path(user)
      end
    else
      flash[:alert] =
        t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
  end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  # def after_sign_in_path_for(resource_or_scope)
  #   dashboard_index_path || root_path
  # end

  private

  def from_google_params
    @from_google_params ||= {
      uid: auth.uid,
      email: auth.info.email,
      full_name: auth.info.name,
      avatar_url: auth.info.image
    }
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end
