class AdvisersController < ApplicationController
  before_action :validate

  def show
    @adviser = @current_user.adviser
  end

  def profile
    if request.post?

    else

    end
  end

  private

  def validate
    unless @current_user.is_adviser?
      cookies.delete(:auth_token)
      redirect_to signin_path and return false
    end
  end
end
