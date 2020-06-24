class AdminsController < ApplicationController

	def dashboard
	end
	
  def enterprises
  	@enterprises = Enterprise.all
  end

  def advisers
  end
end
