class EnterprisesController < ApplicationController
  def index

  end

  def new

  end

  def create
    @enterprise = Enterprise.new(enterprise_params)
    @enterprise.save
    redirect_to @enterprise
  end

  private
  def enterprise_params
    params.require(:enterprise).permit(:business_name,:contact_email,:start_of_operations_date,
                                       :registration_date,:postal_address,:postal_code,:country,
                                       :city,:office_number,:office_phone)
  end
end
