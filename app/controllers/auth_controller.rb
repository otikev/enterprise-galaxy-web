class AuthController < ActionController::Base
  def signin

  end

  def signup

  end

  def enterprise
    if request.post?
      @user = User.new(user_params)
      if @user.save
        EnterpriseMailer.account_activation(@user, @user.enterprise.business_name).deliver_now
        flash[:success] = "Registration success! Please check your email to activate your account."
        redirect_to :controller => 'auth',:action => 'signin'
      else
        render 'enterprise'
      end
    else
      @user = User.new
    end
  end

  def adviser
    if request.post?

    else

    end
  end

  private

  def user_params
    params.require(:user).permit(:email,:password,
                                 enterprise_attributes:[:business_name,:business_form_id,:broad_sector_name_id,
                                                        :registration_date,:start_of_operations_date,:country])
  end
end
