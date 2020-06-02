class AuthController < ActionController::Base
  def signin

  end

  def signup

  end

  def enterprise
    if request.post?
      @enterprise = Enterprise.new(enterprise_params)

      if @enterprise.save
        EnterpriseMailer.account_activation(@enterprise).deliver_now
        flash[:info] = "Please check your email to activate your account."
        redirect_to success
      else
        render 'new'
      end
    else
      @enterprise = Enterprise.new
    end
  end

  def adviser
    if request.post?

    else

    end
  end

  private
  def enterprise_params
    params.require(:enterprise).permit(:business_name,:business_form_id,:broad_sector_name_id,
                                       :registration_date,:start_of_operations_date,:country,
                                       :contact_email)
  end
end
