class AuthController < ActionController::Base

  def activate
    user = User.find_by(email: params[:email], activation_token: params[:activation])

    if user && !user.activated?
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      user.update_attribute(:activation_token, nil)
      flash[:success] = params[:email]+" account activated!"
    else
      flash[:danger] = "Invalid activation link!"
    end

    redirect_to signin_path
  end

  def two_factor
    if request.post?
      code = params[:user][:mfa_code]
      email = params[:user][:email]
      @user = User.where(email: email).first
      if @user
        success = @user.two_factor(code)
        if success
          cookies[:auth_token] = @user.auth_token
          if @user.is_enterprise?
            redirect_to enterprise_dashboard_path(id: @user.enterprise.id) and return true
          elsif @user.is_adviser?
            redirect_to adviser_dashboard_path(id: @user.adviser.id) and return true
          end
        else
          @user.errors[:base] << "Invalid code"
        end
      else
        redirect_to signin_path
      end
    else
      @user = User.where(auth_token: params[:token]).first
      if @user
        @user.update_attribute(:auth_token,nil)
      else
        redirect_to signin_path and return false
      end
    end
  end

  def signout
    if cookies[:auth_token] && cookies[:auth_token].length > 0
      user = User.find_by_auth_token!(cookies[:auth_token])
      if user
        user.update_attribute(:auth_token,nil)
      end
      cookies.delete(:auth_token)
    end
    redirect_to signin_path
  end

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
          if user.activated?
            @user = user.authenticate(password)
            if @user
              if !@user.enabled?
                cookies.delete(:auth_token)
                @user = User.new
                @user.errors[:base] << "Invalid username or password"
              else

                if @user.two_factor?
                  redirect_to multi_factor_path(token: @user.auth_token) and return true
                end

                cookies[:auth_token] = @user.auth_token

                if @user.is_enterprise?
                  redirect_to enterprise_dashboard_path and return true
                elsif @user.is_adviser?
                  redirect_to adviser_dashboard_path and return true
                end
              end
            else
              #user found but password is incorrect
              @user = User.new
              @user.errors[:base] << "Invalid username or password"
            end
          else
            if user.is_enterprise?
              EnterpriseMailer.account_activation(@user, @user.enterprise.business_name).deliver_now
            elsif user.is_adviser?
              EnterpriseMailer.account_activation(@user, @user.adviser.first_name).deliver_now
            end
            @user = User.new
            @user.errors[:base] << "This account has not been activated, please check your email for the activation link"
          end
        else
          #user with email and role not found in db
          @user = User.new
          @user.errors[:base] << "Invalid username or password"
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

  def password_reset
    if request.post?
      @password_request = PasswordRequest.where(:token => params[:password_request][:token]).first
      if @password_request
        @password_request.change_password(params[:password_request][:password],params[:password_request][:password_confirmation])
        unless @password_request.errors.any?
          flash[:success] = 'your new password has been saved, you can now login'
          @password_request.delete
          redirect_to signin_path
        end
      else
        flash[:danger] = 'Something went wrong!'
      end
    else
      token = params[:token]
      @password_request = PasswordRequest.where(:token => token, :used => false).first
      unless @password_request
        flash[:danger] = 'Invalid password reset link.'
        redirect_to signin_path
      end
    end
  end

  def forgot_password
    if request.post?
      email = params[:email]
      if email && email.length > 0
        u = User.find_by_email(email)
        if u
          exists = PasswordRequest.where(:user_id => u.id, :used => false).first
          if exists
            exists.delete
          end

          success = PasswordRequest.send_password_reset(email)
          if success
            puts "Password request success"
          else
            puts "Password request failed"
          end
          flash[:info]  = 'Check your email for a password reset link.'
          redirect_to signin_path
        else
          #email doesn't exist
          #to prevent bad guys using the password reset tool to know if an email exists we'll just say an email has been sent
          flash[:info]  = 'Check your email for a password reset link.'
          redirect_to  signin_path
        end
      else
        flash[:warning] = 'The email cannot be blank'
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation,
                                 {enterprise_attributes:[:business_name,:business_form_id,:broad_sector_name_id,
                                                        :registration_date,:start_of_operations_date,:country,
                                                         :phone,:referral]},
                                 {adviser_attributes:[:title,:first_name,:other_names,:date_of_birth,:cell_phone,
                                                     :country_of_residence]})
  end
end
