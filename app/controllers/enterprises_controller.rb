class EnterprisesController < ApplicationController

  def show
    @enterprise = @current_user.enterprise
    @business_form = BusinessForm.where(id:@enterprise.business_form_id).first
    @broad_sector = BroadSectorName.where(id:@enterprise.broad_sector_name_id).first
  end

  def dashboard

  end

  def edit_profile
    if request.post?
      @current_user.enterprise.update_attributes(enterprise_params.reject{|_, v| v.blank?})
    end
  end

  private

  def enterprise_params
    params.require(:enterprise).permit(:business_name,:business_form_id,:broad_sector_name_id,
                                       :start_of_operations_date,:registration_date,:postal_address,
                                       :postal_code,:country,:city,:office_number,:office_phone,
                                       :referral,:office_mobile_number,:office_location_hq,
                                     :google_map_location,:main_sector,:sub_sector,:name_of_founder,
                                   :founder_mobile_number,:founder_gender,:founder_date_of_birth,
                                 :financial_year_start_date,:financial_year_end_date,:mission,
                               :vision,:punch_line,:brand_logo,:brief_service_description,
                             :num_employees_fulltime,:num_employees_parttime)
  end

  def validate
    #If no user logged in, destroy cookie and show signin page
    unless @current_user
      cookies.delete(:auth_token)
      redirect_to signin_path and return false
    end

    #If current user is not an enterprise, redirect to adviser page
    unless @current_user.is_enterprise?
      redirect_to adviser_dashboard_path and return false
    end
  end
end
