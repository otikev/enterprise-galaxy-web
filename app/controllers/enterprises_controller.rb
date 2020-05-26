class EnterprisesController < ApplicationController
  def index

  end

  def new

  end

  def create
    @business_forms = BusinessForm.all
    @enterprise = Enterprise.new(enterprise_params)
    
    if @enterprise.save
      EnterpriseMailer.account_activation(@enterprise).deliver_now
      flash[:info] = "Please check your email to activate your account."    
      redirect_to @enterprise
    else
      render 'new'
    end
  end

  private
  def enterprise_params
    params.require(:enterprise).permit(:business_name,:contact_email,:start_of_operations_date,
                                       :registration_date,:postal_address,:postal_code,:country,
                                       :city,:office_number,:office_phone,:business_form_id,:broad_sector_name_id)
  end
end
