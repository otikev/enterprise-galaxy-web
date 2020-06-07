class AuthController < ActionController::Base
  def signin
    if request.post?
      email = params[:user][:email]
      password = params[:user][:password]
      if !email || email == '' || !password || password == ''
        flash.now[:warning]='You must provide an email and password'
        @user = User.new
      else
        user = User.where(email: email).first

        if user
          @user = user.authenticate(password, true)
          if @user
            if !@user.enabled
              cookies.delete(:auth_token)
              @user = nil
              flash.now[:danger] = 'Your account has been disabled'
              @user = User.new
            else
              cookies[:auth_token] = @user.auth_token
              redirect_to dashboard_path and return true
            end
          else
            #user found but password is incorrect
            flash.now[:danger]='Invalid username or password'
            @user = User.new
          end
        else
          #user with email and role not found in db
          flash.now[:danger]='Invalid username or password'
          @user = User.new
        end
      end
    else
      @user = User.new
    end
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
      @enterprise = Enterprise.new
    end
  end

  def adviser
    if request.post?
      @user = User.new(user_params)
      if @user.save
        EnterpriseMailer.account_activation(@user, @user.adviser.first_name).deliver_now
        flash[:success] = "Registration success! Please check your email to activate your account."
        redirect_to :controller => 'auth',:action => 'signin'
      else
        render 'adviser'
      end
    else
      @user = User.new
      @adviser = Adviser.new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation,
                                 {enterprise_attributes:[:business_name,:business_form_id,:broad_sector_name_id,
                                                        :registration_date,:start_of_operations_date,:country]},
                                 {adviser_attributes:[:title,:first_name,:other_names,:date_of_birth,:cell_phone,
                                                     :country_of_residence]})
  end
end
