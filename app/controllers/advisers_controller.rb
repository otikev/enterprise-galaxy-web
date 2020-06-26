class AdvisersController < ApplicationController
  before_action :validate

  def show
    @adviser = @current_user.adviser
  end

  def dashboard; end

  def edit_profile
    @current_user.adviser.update_attributes(adviser_params.reject { |_, v| v.blank? }) if request.post?
  end

  private

  def adviser_params
    params.require(:adviser).permit(:title, :first_name, :other_names, :date_of_birth, :cell_phone, :gender,
                                    :country_of_residence, :nationality, :po_box, :city, :personal_email, :work_email,
                                    :preferred_mode_of_comms, :employment_status, :current_employer)
  end

  def validate
    # If no user logged in, destroy cookie and show signin page
    unless @current_user
      cookies.delete(:auth_token)
      redirect_to signin_path and return false
    end

    # If current user is not an adviser, redirect to enterprise page
    redirect_to enterprise_dashboard_path and return false unless @current_user.is_adviser?
  end
end
