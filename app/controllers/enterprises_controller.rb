class EnterprisesController < ApplicationController
  def index

  end

  def new

  end

  def success

  end

  def signup

  end

  def show
    @enterprise = Enterprise.where(:id => params[:id]).first
  end

  def create
    @enterprise = Enterprise.new(enterprise_params)
    
    if @enterprise.save
      EnterpriseMailer.account_activation(@enterprise).deliver_now
      flash[:info] = "Please check your email to activate your account."    
      redirect_to success
    else
      render 'new'
    end
  end

  private
  def enterprise_params
    params.require(:enterprise).permit(:business_name,:contact_email,:start_of_operations_date,
                                       :registration_date,:postal_address,:postal_code,:country,
                                       :city,:office_number,:office_phone,:business_form_id,:broad_sector_name_id,
                                       :registration_date,:start_of_operations_date)
  end
end
