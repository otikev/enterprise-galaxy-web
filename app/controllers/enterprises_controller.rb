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
                                       :registration_date,:start_of_operations_date,:country,
                                       :phone,:referral)
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
