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
              @user = User.new
              @user.errors[:base] << "Your account has been disabled"
            else
              cookies[:auth_token] = @user.auth_token
              redirect_to dashboard_path and return true
            end
          else
            #user found but password is incorrect
            @user = User.new
            @user.errors[:base] << "Invalid username or password 1"
          end
        else
          #user with email and role not found in db
          @user = User.new
          @user.errors[:base] << "Invalid username or password 2"
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
        @password_request.change_password( params[:password_request][:password],params[:password_request][:password_confirmation])
        if !@password_request.errors.any?
          flash[:success]='your new password has been saved, you can now login'
          @password_request.delete
          redirect_to role_path
        end
      else
        flash[:danger] = 'Something went wrong!'
      end
    else
      token = params[:token]
      @password_request = PasswordRequest.where(:token => token).first
      if @password_request
      else
        flash[:danger] = 'Invalid password reset link.'
        redirect_to role_path
      end
    end
  end

  def forgot_password
    if request.post?
      email = params[:email]
      if email && email.length > 0
        u = User.find_by_email(email)
        if u
          exists = PasswordRequest.where(:user_id => u.id).first
          if exists
            flash[:warning] = "There is a pending password request for this email: #{email}"
          else
            PasswordRequest.send_password_reset(email)
            flash[:info]  = 'Check your email for a password reset link.'
            redirect_to signin_path
          end
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
                                                        :registration_date,:start_of_operations_date,:country]},
                                 {adviser_attributes:[:title,:first_name,:other_names,:date_of_birth,:cell_phone,
                                                     :country_of_residence]})
  end
end
