class AdvisersController < ApplicationController
  before_action :validate

  def show
    @adviser = @current_user.adviser
  end

  def dashboard

  end

  def profile
    if request.post?

    else

    end
  end

  private

  def validate
    #If no user logged in, destroy cookie and show signin page
    unless @current_user
      cookies.delete(:auth_token)
      redirect_to signin_path and return false
    end

    #If current user is not an adviser, redirect to enterprise page
    unless @current_user.is_adviser?
      redirect_to enterprise_dashboard_path and return false
    end
  end
end
