class ApplicationController < ActionController::Base
  before_action :fetch_logged_in_user
  require 'utils'

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  def fetch_logged_in_user
    @current_url = request.url
    return unless cookies[:auth_token]

    if cookies[:auth_token] && cookies[:auth_token].length > 0
      @current_user ||= User.find_by!(auth_token: cookies[:auth_token])
    end
    if @current_user
      unless @current_user.enabled
        cookies.delete(:auth_token)
        redirect_to signin_path and return false
      end
    else
      if cookies[:auth_token] && cookies[:auth_token].length > 0
        flash[:warning] = 'You were logged out because someone else has logged in with your account.'
      end
      cookies.delete(:auth_token)
      redirect_to signin_path and return false
    end
  rescue Exception => e
    @current_user = nil
    cookies.delete(:auth_token)
    redirect_to signin_path and return false
  end
end
