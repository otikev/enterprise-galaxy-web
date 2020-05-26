class AccountActivationsController < ApplicationController
	def edit
		enterprise = Enterprise.find_by(contact_email: params[:contact_email])

		if enterprise && !enterprise.activated? && enterprise.authenticated?(:activation, params[:id])
			enterprise.update_attribute(:activated, true)
			enterprise.update_attribute(:activated_at, Time.zone.now)
			
			# TODO: log_in enterprise
			
			flash[:success] = "Account activated!"
			redirect_to enterprise
		else
			flash[:danger] = "Invalid activation link"
			redirect_to root_url
		end		
	end	
end
